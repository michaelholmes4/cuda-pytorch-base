# CUDA PyTorch Base Image

Public base image with CUDA 12.8, Python 3.11, uv, and PyTorch 2.7.1 pre-installed.

## Image Tags

- `ghcr.io/michaelholmes4/cuda-pytorch-base:latest` - Latest build
- `ghcr.io/michaelholmes4/cuda-pytorch-base:cu128-torch271-py311` - Specific version

## What's Included

- **NVIDIA CUDA**: 12.8.0 runtime
- **Python**: 3.11
- **uv**: Fast Python package manager
- **PyTorch**: 2.7.1 (with CUDA 12.8 support)
- **Tools**: git, curl, rclone, wget

## Pre-installed Packages

- torch==2.7.1
- torchvision==0.22.1
- torchaudio==2.7.1
- numpy
- scipy
- tensorboard

## Usage

```dockerfile
FROM ghcr.io/michaelholmes4/cuda-pytorch-base:latest

# Your additional setup
RUN uv pip install --system your-package

WORKDIR /workspace
```

## Building Locally

```bash
docker build -t cuda-pytorch-base:local .
```

## Automatic Builds

This image is automatically built and published to GitHub Container Registry on:
- Push to `main` branch (tagged as `latest`)
- New git tags (tagged with version number)
