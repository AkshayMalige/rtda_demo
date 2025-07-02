# Installing the Python Environment

To set up the Python environment required for this project, use the `hls_env.yml` file provided:

```bash
conda env create -f hls_env.yml
conda activate hls_env
```

# Automatic Directory Generation

The Python script `project.py` in this folder will help you generate an appropriate directory structure for your AIE projects with pre-populated `Makefile`.

## Default directory structure

The Python script will generate an structure like this one

```console
├── aie
│   ├── constraints
│   ├── data
│   ├── Makefile
│   └── src
├── host
│   └── Makefile
├── hw_link
│   └── config.cfg
├── Makefile
└── pl
    ├── Makefile
    └── src
```

## Using the script

```bash
python3 project.py --name <project_name>
```

---------------------------------------
<p align="center">Copyright&copy; 2023 Advanced Micro Devices</p>
