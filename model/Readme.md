# Data generation for model

This directory contains utilities and notebooks for generating training data for the reduced-order detector model.

## Generate Reduced-Order Model Detector Data

Run the following steps to create the dataset:

```bash
git clone https://github.com/abidihaider/RealTimeAlignment.git
cd RealTimeAlignment
git checkout origin/develop
python setup.py develop
cd RealtimeAlignment/onnx_no-residual
cp ../../dump_vals.ipynb .
```

The `dump_vals.ipynb` notebook exports intermediate detector values required to train the reduced-order model. Execute the notebook to produce the data and save the resulting files in the `data/` directory for subsequent training steps.
