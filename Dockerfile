# CUDA + Python + uv base image for ML projects
FROM nvidia/cuda:12.8.0-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    UV_SYSTEM_PYTHON=1

RUN apt-get update && apt-get install -y \
    git \
    curl \
    rclone \
    wget \
    ca-certificates \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Install Python 3.12 using uv
RUN uv python install 3.12

# Pre-install PyTorch with CUDA 12.8 support
RUN uv pip install --system --python 3.12 \
    torch==2.7.1 \
    torchvision==0.22.1 \
    torchaudio==2.7.1 \
    --index-url https://download.pytorch.org/whl/cu128

# Pre-install common scientific packages
RUN uv pip install --system --python 3.12 \
    numpy \
    scipy \
    tensorboard

# Setup SSH for Runpod
RUN mkdir -p /var/run/sshd && \
    mkdir -p ~/.ssh && \
    chmod 700 ~/.ssh && \
    ssh-keygen -A

# Expose SSH port
EXPOSE 22

WORKDIR /workspace

CMD ["/bin/bash"]
