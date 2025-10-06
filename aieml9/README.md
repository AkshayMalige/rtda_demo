# AIEML9 Combined Graph

`aieml9` stitches together the three existing AI Engine stages (`aieml6`,
`aieml7`, and `aieml8`) into a single graph. The embedded feature extractor,
solver stack, and output projection now execute in a single compilation unit so
that `make graph` builds the whole network in one go.

## Build

```bash
make graph
```

The graph expects the same data files as the original projects. The final
result is dumped to `data/aieml9_output_aie.txt`.
