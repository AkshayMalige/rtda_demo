# Installing the Python Environment

To set up the Python environment required for this project, use the `hls_env.yml` file provided:

```bash
conda env create -f hls_env.yml
conda activate hls_env
```

## Setting up enviornment

```bash
source set_envs.sh
```


# Directory structure

The Python script will generate an structure like this one

```console
├── aie
│   ├── data
│   ├── Makefile
│   └── src
├── host
│   └── Makefile
├── hw_link
│   └── system.cfg
├── Makefile
└── pl
    ├── Makefile
    └── src files (.cpp)
```



---------------------------------------
