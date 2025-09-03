#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Poster Progress Bar (PNG + SVG)
- Flexible: drive via YAML/JSON or --item "Label|0.75|Note" flags
- Placeholders: use percent = null / NA / - to render hatched bars with "—"
- Palette defaults match your poster (AIE/PL/PS scheme-friendly)

Usage examples:
  python tools/poster_progress.py --config progress.yaml --out-prefix assets/status
  python tools/poster_progress.py --title "Project Status — {date}" \
    --item "ML model & datasets|0.8|Trained + validated" \
    --item "Full-system bring-up (VEK280)|0.4|Interconnect tuning" \
    --item "DAQ hookup|NA|TBD"

Requires: Pillow
Optional: PyYAML (if using YAML), or just JSON.
"""

import argparse, json, math, os, sys
from datetime import datetime

try:
    import yaml  # type: ignore
    HAVE_YAML = True
except Exception:
    HAVE_YAML = False

from PIL import Image, ImageDraw, ImageFont
import xml.etree.ElementTree as ET

# ---------------------------
# Helpers
# ---------------------------
def parse_items(args_items):
    parsed = []
    for raw in args_items:
        parts = raw.split("|")
        if len(parts) < 1:
            continue
        label = parts[0].strip()
        pct = parts[1].strip() if len(parts) > 1 else ""
        note = parts[2].strip() if len(parts) > 2 else ""
        if pct in ("", "NA", "na", "-", "None", "null"):
            percent = None
        else:
            # allow "75" or "0.75"
            try:
                val = float(pct)
                percent = val/100.0 if val > 1.0 else val
                percent = max(0.0, min(1.0, percent))
            except Exception:
                percent = None
        parsed.append({"label": label, "percent": percent, "note": note})
    return parsed

def load_config(path):
    with open(path, "r", encoding="utf-8") as f:
        text = f.read()
    if path.lower().endswith((".yml", ".yaml")):
        if not HAVE_YAML:
            raise RuntimeError("PyYAML not installed. pip install pyyaml")
        cfg = yaml.safe_load(text)
    else:
        cfg = json.loads(text)
    if not isinstance(cfg, dict) or "items" not in cfg:
        raise ValueError("Config must be an object with an 'items' key.")
    return cfg

def load_font(path, size):
    if path and os.path.exists(path):
        try:
            return ImageFont.truetype(path, size)
        except Exception:
            pass
    # Fallbacks
    for candidate in ["DejaVuSans.ttf", "Arial.ttf"]:
        try:
            return ImageFont.truetype(candidate, size)
        except Exception:
            continue
    return ImageFont.load_default()

def draw_wrapped(draw, text, font, x, y, max_width, color):
    """Simple word-wrap for PIL; returns bottom y of the drawn block."""
    if not text:
        return y
    words = text.split()
    line = ""
    lh = font.getbbox("Hg")[3] - font.getbbox("Hg")[1]
    cur_y = y
    for w in words:
        test = (line + " " + w).strip()
        wbox = draw.textbbox((0, 0), test, font=font)
        if wbox[2] - wbox[0] <= max_width or not line:
            line = test
        else:
            draw.text((x, cur_y), line, fill=color, font=font)
            cur_y += lh + 2
            line = w
    if line:
        draw.text((x, cur_y), line, fill=color, font=font)
        cur_y += lh
    return cur_y

def hatch_rect(draw, x0, y0, x1, y1, step=10, color="#CFCFCF"):
    for x in range(int(x0), int(x1)+step, step):
        draw.line([(x, y0), (x-8, y1)], fill=color, width=1)

# ---------------------------
# Core render
# ---------------------------
def render(title, items, out_prefix, style):
    # Style + layout
    padding = style["padding"]
    bar_h = style["bar_height"]
    gap = style["gap"]
    label_w = style["label_width"]
    bar_w = style["bar_width"]
    right_margin = 100
    bg_rgba = style["bg_rgba"]
    note_wrap = style["note_wrap"]

    # Canvas size (approx; adjust with fonts)
    width = padding*2 + label_w + bar_w + right_margin
    # Estimate title height:
    img_tmp = Image.new("RGBA", (10, 10), (0, 0, 0, 0))
    dtmp = ImageDraw.Draw(img_tmp)
    th = style["title_font"].getbbox("Hg")[3] - style["title_font"].getbbox("Hg")[1]
    lbl_h = style["label_font"].getbbox("Hg")[3] - style["label_font"].getbbox("Hg")[1]
    note_h = style["note_font"].getbbox("Hg")[3] - style["note_font"].getbbox("Hg")[1]

    # Compute height more precisely with note wrapping
    y = padding + th + 20
    for it in items:
        # label line
        y += max(bar_h, lbl_h)
        # note block (may wrap)
        if it.get("note"):
            # rough wrap width equals label_w (drawn under label)
            # but we want the note to start under the label, not under the bar.
            lines = math.ceil(len(it["note"]) * style["note_font_size"] * 0.5 / note_wrap)
            # conservative estimate: let PIL wrap precisely during drawing; add 1 line min
            y += note_h * max(1, lines)
        else:
            y += note_h  # minimal spacing even if empty
        y += gap
    height = y + padding

    # --- PNG ---
    img = Image.new("RGBA", (width, height), bg_rgba)
    draw = ImageDraw.Draw(img)

    # Title (allow {date})
    title_text = title.replace("{date}", datetime.now().strftime("%b %d, %Y"))
    draw.text((padding, padding), title_text, fill=style["text_color"], font=style["title_font"])

    y = padding + th + 20
    for it in items:
        label = it.get("label","")
        pct = it.get("percent", None)
        note = it.get("note","")

        # Label
        draw_wrapped(draw, label, style["label_font"], padding, y, label_w, style["text_color"])
        # Bar background
        bx = padding + label_w + 20
        by = y
        draw.rounded_rectangle([bx, by, bx+bar_w, by+bar_h], radius=8,
                               fill=style["bar_bg"], outline=style["bar_stroke"])
        # Fill / hatch
        if pct is not None and pct >= 0.0:
            fill_w = int(bar_w * min(1.0, pct))
            draw.rounded_rectangle([bx, by, bx+fill_w, by+bar_h], radius=8,
                                   fill=style["accent_fill"])
            pct_text = f"{int(round(pct*100))}%"
        else:
            hatch_rect(draw, bx, by, bx+bar_w, by+bar_h, step=10, color="#CFCFCF")
            pct_text = "—"

        # Percent text
        draw.text((bx+bar_w+12, by + max(0, (bar_h - style["pct_font_size"])//2 + 2)),
                  pct_text, fill=style["text_color"], font=style["pct_font"])

        # Advance y by bar height (and ensure at least label height space is used)
        y += max(bar_h, lbl_h)

        # Note under label (wrap to label width)
        if note:
            y = draw_wrapped(draw, note, style["note_font"], padding, y+4, note_wrap, style["subtitle_color"])
        else:
            y += note_h

        # Gap between rows
        y += gap

    # Save PNG
    png_path = f"{out_prefix}.png"
    img.save(png_path)

    # --- SVG ---
    svg = ET.Element("svg", attrib={
        "xmlns": "http://www.w3.org/2000/svg",
        "width": str(width),
        "height": str(height),
        "viewBox": f"0 0 {width} {height}"
    })
    # Background only if opaque
    if bg_rgba[3] == 255:
        ET.SubElement(svg, "rect", x="0", y="0", width=str(width), height=str(height),
                      fill=f"rgb({bg_rgba[0]},{bg_rgba[1]},{bg_rgba[2]})")

    def svg_text(parent, txt, x, y, size, weight="400", color="#000", anchor="start"):
        t = ET.SubElement(parent, "text", x=str(x), y=str(y),
                          fill=color,
                          style=f"font-family:DejaVu Sans, Arial; font-size:{size}px; font-weight:{weight};",
                          **({"text-anchor": anchor} if anchor else {}))
        t.text = txt
        return t

    svg_text(svg, title_text, padding, padding + style["title_font_size"], style["title_font_size"],
             weight="700", color=style["text_color"])

    y = padding + th + 20
    for it in items:
        label = it.get("label","")
        pct = it.get("percent", None)
        note = it.get("note","")

        # Label
        svg_text(svg, label, padding, y + style["label_font_size"], style["label_font_size"], color=style["text_color"])

        # Bar
        bx = padding + label_w + 20
        by = y
        ET.SubElement(svg, "rect", x=str(bx), y=str(by), width=str(bar_w), height=str(bar_h),
                      rx="8", ry="8", fill=style["bar_bg"], stroke=style["bar_stroke"])
        if pct is not None and pct >= 0.0:
            fill_w = int(bar_w * min(1.0, pct))
            ET.SubElement(svg, "rect", x=str(bx), y=str(by), width=str(fill_w), height=str(bar_h),
                          rx="8", ry="8", fill=style["accent_fill"])
            pct_text = f"{int(round(pct*100))}%"
        else:
            # hatch
            step = 10
            xi = bx
            while xi <= bx + bar_w:
                ET.SubElement(svg, "line", x1=str(xi), y1=str(by), x2=str(xi-8), y2=str(by+bar_h),
                              stroke="#CFCFCF", **{"stroke-width":"1"})
                xi += step
            pct_text = "—"

        svg_text(svg, pct_text, bx+bar_w+12, by + style["pct_font_size"] + 2,
                 style["pct_font_size"], weight="700", color=style["text_color"])

        # advance y by bar height/label height
        y += max(bar_h, lbl_h)

        # Note
        if note:
            # No SVG wrapping: just print one line; keep short in config
            svg_text(svg, note, padding, y + style["note_font_size"], style["note_font_size"],
                     color=style["subtitle_color"])
            y += style["note_font_size"]
        else:
            y += note_h
        y += gap

    svg_path = f"{out_prefix}.svg"
    ET.ElementTree(svg).write(svg_path, encoding="utf-8", xml_declaration=True)

    return png_path, svg_path

# ---------------------------
# Main
# ---------------------------
def main():
    p = argparse.ArgumentParser(description="Generate poster progress bar (PNG+SVG).")
    p.add_argument("--config", help="YAML/JSON file: { items: [ {label, percent, note}, ... ], title?, colors? }")
    p.add_argument("--item", action="append", default=[],
                   help="Add an item as 'Label|percent|Note'. percent in [0..1] or [0..100]; use NA/-/None for placeholder.")
    p.add_argument("--title", default="Project Status — {date}",
                   help="Title text; supports {date} placeholder.")
    p.add_argument("--out-prefix", default="project_status_progress_bar",
                   help="Output path prefix (no extension).")
    # Styling
    p.add_argument("--accent", default="#00B4D8")
    p.add_argument("--bar-bg", default="#E6E6E6")
    p.add_argument("--bar-stroke", default="#CCCCCC")
    p.add_argument("--text-color", default="#1C1C1C")
    p.add_argument("--subtitle-color", default="#3A3A3A")
    p.add_argument("--bg", default="transparent", help="transparent or #RRGGBB")
    # Layout
    p.add_argument("--padding", type=int, default=40)
    p.add_argument("--bar-height", type=int, default=28)
    p.add_argument("--gap", type=int, default=22)
    p.add_argument("--label-width", type=int, default=430)
    p.add_argument("--bar-width", type=int, default=720)
    p.add_argument("--note-wrap", type=int, default=430, help="Wrap width (px) for note under label (PNG only).")
    # Fonts
    p.add_argument("--font-path", default="", help="Path to a TTF to use for all text (falls back if missing).")
    p.add_argument("--title-font-size", type=int, default=36)
    p.add_argument("--label-font-size", type=int, default=22)
    p.add_argument("--note-font-size", type=int, default=16)
    p.add_argument("--pct-font-size", type=int, default=20)
    args = p.parse_args()

    items = []
    title = args.title
    colors = {
        "accent_fill": args.accent,
        "bar_bg": args.bar_bg,
        "bar_stroke": args.bar_stroke,
        "text_color": args.text_color,
        "subtitle_color": args.subtitle_color,
    }

    if args.config:
        cfg = load_config(args.config)
        title = cfg.get("title", title)
        # colors from config (if any)
        for k in ["accent_fill", "bar_bg", "bar_stroke", "text_color", "subtitle_color"]:
            if k in cfg:
                colors[k] = cfg[k]
        items = cfg["items"]

    if args.item:
        items.extend(parse_items(args.item))

    if not items:
        print("No items provided. Use --config or --item flags.", file=sys.stderr)
        sys.exit(2)

    # Normalize items (percent may be 0..100 or 0..1 or None)
    norm = []
    for it in items:
        label = it.get("label", "")
        note = it.get("note", "")
        pct = it.get("percent", None)
        if pct is not None:
            try:
                val = float(pct)
                if val > 1.0:
                    val = val / 100.0
                pct = max(0.0, min(1.0, val))
            except Exception:
                pct = None
        norm.append({"label": label, "percent": pct, "note": note})

    # Background color
    if args.bg.lower() == "transparent":
        bg_rgba = (255, 255, 255, 0)
    else:
        # hex to rgb
        h = args.bg.lstrip("#")
        r, g, b = int(h[0:2], 16), int(h[2:4], 16), int(h[4:6], 16)
        bg_rgba = (r, g, b, 255)

    # Fonts
    style = {
        "accent_fill": colors["accent_fill"],
        "bar_bg": colors["bar_bg"],
        "bar_stroke": colors["bar_stroke"],
        "text_color": colors["text_color"],
        "subtitle_color": colors["subtitle_color"],
        "padding": args.padding,
        "bar_height": args.bar_height,
        "gap": args.gap,
        "label_width": args.label_width,
        "bar_width": args.bar_width,
        "bg_rgba": bg_rgba,
        "note_wrap": args.note_wrap,
        "title_font_size": args.title_font_size,
        "label_font_size": args.label_font_size,
        "note_font_size": args.note_font_size,
        "pct_font_size": args.pct_font_size,
    }
    style["title_font"] = load_font(args.font_path, args.title_font_size)
    style["label_font"] = load_font(args.font_path, args.label_font_size)
    style["note_font"]  = load_font(args.font_path, args.note_font_size)
    style["pct_font"]   = load_font(args.font_path, args.pct_font_size)

    png, svg = render(title, norm, args.out_prefix, style)
    print(f"PNG: {png}")
    print(f"SVG: {svg}")

if __name__ == "__main__":
    main()
