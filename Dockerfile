# CUDA + Python + uv base image for ML projects
FROM nvidia/cuda:12.8.0-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    UV_SYSTEM_PYTHON=1

RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update && apt-get install -y \
    git \
    curl \
    rclone \
    wget \
    ca-certificates \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Setup SSH for Runpod
RUN mkdir -p /var/run/sshd && \
    mkdir -p ~/.ssh && \
    chmod 700 ~/.ssh && \
    ssh-keygen -A

# Expose SSH port
EXPOSE 22

WORKDIR /workspace

CMD ["/bin/bash"]
