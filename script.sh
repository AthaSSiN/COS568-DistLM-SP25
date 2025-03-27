#!/bin/bash

sudo apt-get update
sudo apt-get install htop dstat python3-pip -y
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
    
pip install torch==2.5.0 torchvision==0.20.0 torchaudio==2.5.0 --index-url https://download.pytorch.org/whl/cpu
pip install numpy scipy scikit-learn tqdm pytorch_transformers apex