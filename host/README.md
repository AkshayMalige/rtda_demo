# Host Application

The host application configures the AI Engine graph and PL kernels at runtime. It runs on the Versal processing system and streams data through XRT.

## Build

Cross-compile the program using the provided Makefile and PetaLinux sysroot:

```bash
make            # builds `system_host`
```

Adjust the `SYSROOT` variable in the Makefile if your sysroot resides elsewhere.
