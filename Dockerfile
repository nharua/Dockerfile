# Base Image: CUDA with Ubuntu 22.04
FROM nvidia/cuda:12.6.2-base-ubuntu22.04

# Set working directory and shell
USER root
WORKDIR /root
SHELL [ "/usr/bin/bash", "-c" ]

SHELL [ "/usr/bin/bash", "-c" ]

# Set (temporarily) DEBIAN_FRONTEND to avoid interacting with tzdata
ENV TZ=Asia/Ho_Chi_Minh \
    DEBIAN_FRONTEND=noninteractive
	
# Use C.UTF-8 locale to avoid issues with ASCII encoding
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# System Update & Package Installation
RUN apt update && apt upgrade -y && \
    apt install -y \
        git \
        make \
        gcc \
        g++ \
        libboost-all-dev \
        libssl-dev \
        libcpprest-dev \
        sudo \
        tree \
        dbus-x11 \
        bash-completion \
        curl \
        wget \
        python3-pip \
        vim \
        vim-gtk3 \
        meld \
        tmux \
        software-properties-common \
        libgtk2.0-dev \
        libgtk-3-dev \
        pkg-config

# Install Latest Neovim
RUN add-apt-repository ppa:neovim-ppa/stable -y && \
    add-apt-repository ppa:neovim-ppa/unstable -y && \
    apt update && \
    apt install -y neovim python3-neovim luarocks && \
    luarocks install jsregexp && \
    pip3 install --upgrade pynvim && \
    curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash - && \
    apt install -y nodejs python3-venv

# Install Common Python Packages (Optional, Customize as Needed)
RUN pip3 install --upgrade pip && \
    pip3 install \
        torch torchvision torchaudio \
        jupyterlab \
        numpy scipy pandas matplotlib \
        pylint flake8 black \
        ultralytics \
		opencv-python-headless

# Misc
RUN apt install -y \
		ripgrep \
		fd-find \
		xdg-utils \
		nautilus \
		imagemagick

RUN pip3 install \
		roboflow \
		nvitop

# tilde: TUI Editor
# bashtop: TUI Monitor Tool
RUN apt install -y \
                tilde \ 
                bashtop

# Create a Docker User with Sudo Privileges
ARG USER=docker
RUN useradd -m -s /bin/bash $USER && \
    usermod -aG sudo $USER && \
    echo '%sudo ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Switch to Non-Root User
USER $USER
ENV HOME=/home/$USER
WORKDIR /home/$USER


# Set Python Pip Packages Cache Directory
ENV PIP_CACHE_DIR=/home/$USER/.cache/pip

# How to build 
# docker buildx build --rm --tag vbtech_yolo11 --file .\Dockerfile .

# How to run
# On Linux Host
# docker run --gpus all -it --name vbtech_yolo11 --hostname yolo11 -e DISPLAY=$DISPLAY -e TERM=xterm-256color -e HOME="/home/docker" -v /tmp/.X11-unix:/tmp/.X11-unix -v ~/myWork:/home/docker/myWork vbtech_yolo11 /bin/bash
# On Windows Host
# docker run --gpus all -it --name vbtech_yolo11 --hostname yolo11 -e DISPLAY=host.docker.internal:0 -e TERM=xterm-256color -e HOME="/home/docker" -v c:/!myWork:/home/docker/myWork vbtech_yolo11 /bin/bash
# Run GUI with Build-in Xserver on Windows 11
# https://www.youtube.com/watch?v=UEre6Bd75dw

# Run with attach laptop camera
# docker run --gpus all -it --device /dev/video0:/dev/video0 --name vbtech_yolo11wCam --hostname yolo11 -e DISPLAY=host.docker.internal:0 -e TERM=xterm-256color -e HOME="/home/docker" -v c:/!myWork:/home/docker/myWork vbtech_yolo11 /bin/bash
