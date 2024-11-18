# Docker Image: CUDA with Ubuntu 22.04 for Machine Learning and Development

This repository provides a Dockerfile to create a versatile development environment based on **Ubuntu 22.04** with **CUDA 12.6.2**. It includes essential tools and libraries for machine learning, Python development, and system utilities.

## Features

- **CUDA 12.6.2**: Leverage NVIDIA GPUs for machine learning and deep learning tasks.
- **Python3 & Pip**: Includes Python 3 and essential Python packages for data science.
- **Neovim & Vim**: Latest versions for efficient text editing.
- **Common Development Tools**: Git, GCC, G++, Make, C++ Boost Libraries, and more.
- **Machine Learning Frameworks**: Pre-installed with `torch`, `torchvision`, `torchaudio`, and `ultralytics` for deep learning tasks.
- **GUI and CLI Support**: Supports GUI applications using X11 forwarding, along with CLI tools like `tmux`, `ripgrep`, `fd-find`, etc.
- **Python Libraries**: Includes popular libraries like `numpy`, `pandas`, `opencv-python-headless`, and more.

## Prerequisites

- **Docker** installed on your system.
- **NVIDIA Container Toolkit** for GPU support (if you plan to use GPU acceleration). [Installation Guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

## Building the Docker Image

To build the Docker image, use the following command:

```bash
docker buildx build --rm --tag yolo11 --file Dockerfile .
```

## Running The Docker Container

### For Linux Host

```bash
docker run --gpus all -it \
    --name yolo11 \
    --hostname yolo11 \
    -e DISPLAY=$DISPLAY \
    -e TERM=xterm-256color \
    -e HOME="/home/docker" \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ~/myWork:/home/docker/myWork \
    yolo11 /bin/bash
```

### For Windows Host

```bash
docker run --gpus all -it \
    --name yolo11 \
    --hostname yolo11 \
    -e DISPLAY=host.docker.internal:0 \
    -e TERM=xterm-256color \
    -e HOME="/home/docker" \
    -v c:/!myWork:/home/docker/myWork \
    yolo11 /bin/bash
```

## Additional Notes

- **Using GUI on Windows 11**: To run GUI applications from the container on a Windows 11 host, you need to set up an X server (e.g., Xming or VcXsrv). Refer to [this video guide](https://www.youtube.com/watch?v=UEre6Bd75dw) for detailed instructions.
- **Mounting Volumes**: Customize the `-v` option in the `docker run` command to mount specific directories from your host system to the container. This allows you to easily share files between the host and the container.

## Installed Packages

The Docker image includes a comprehensive set of packages to streamline development and machine learning tasks.

### System Packages

- **Development Tools**: `git`, `make`, `gcc`, `g++`, `libboost-all-dev`, `libssl-dev`
- **Python Tools**: `python3-pip`, `python3-venv`, `jupyterlab`
- **Utilities**: `curl`, `wget`, `tmux`, `vim`, `neovim`, `meld`, `tree`, `bash-completion`
- **GUI Support**: `libgtk2.0-dev`, `libgtk-3-dev`, `nautilus`, `imagemagick`

### Python Libraries

- **Machine Learning**: `torch`, `torchvision`, `torchaudio`, `ultralytics`
- **Data Science**: `numpy`, `scipy`, `pandas`, `matplotlib`
- **Utility Packages**: `pylint`, `flake8`, `black`, `opencv-python-headless`
- **Additional Tools**: `roboflow`, `nvitop`

### Neovim Setup

- **Python3 Integration**: `pynvim`, `python3-neovim` for enhanced Python support in Neovim.
- **Node.js and Luarocks**: Includes Node.js for plugin management, and `luarocks` with `jsregexp` for Lua scripting capabilities.

## User and Permissions

- A non-root user named `docker` is created with **sudo** privileges to enhance security and prevent issues caused by running as the root user.

## Troubleshooting

- **Display Issues on Linux**: Ensure that X11 forwarding is enabled and the `DISPLAY` environment variable is set correctly (`-e DISPLAY=$DISPLAY`).
- **Access Denied for Devices**: If you encounter permission errors when accessing devices (e.g., a camera), verify that Docker has access to the required device (e.g., `/dev/video0`).

## License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for more details.

