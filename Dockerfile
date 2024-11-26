# Base Image: Ubuntu 22.04
FROM ubuntu:22.04

# Set working directory and shell
USER root
WORKDIR /root
SHELL [ "/usr/bin/bash", "-c" ]

# Set (temporarily) DEBIAN_FRONTEND to avoid interacting with tzdata
ENV TZ=Asia/Ho_Chi_Minh \
    DEBIAN_FRONTEND=noninteractive
	
# Use C.UTF-8 locale to avoid issues with ASCII encoding
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# System Update & Package Installation
RUN apt update && \
	apt upgrade -y && \
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
        pkg-config \
		ripgrep \
		fd-find \
		xdg-utils \
		nautilus \
		imagemagick \
		openssh-server

# Install Latest Neovim
RUN curl -L https://github.com/neovim/neovim/releases/download/v0.10.2/nvim-linux64.tar.gz -o nvim-linux64.tar.gz && \
    tar -xzvf nvim-linux64.tar.gz && \
    mv nvim-linux64 /usr/local/nvim && \
    ln -s /usr/local/nvim/bin/nvim /usr/local/bin/nvim && \
    rm -f nvim-linux64.tar.gz
	
RUN apt install -y python3-neovim luarocks && \
    luarocks install jsregexp && \
    pip3 install --upgrade pynvim && \
    curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash - && \
    apt install -y nodejs python3-venv

# Create a Docker User with Sudo Privileges
ARG USER=docker
ARG PASSWD=pass@123
RUN useradd -m -s /bin/bash $USER && \
    usermod -aG sudo $USER && \
    echo '%sudo ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
	echo "$USER:$PASSWD" | chpasswd

# Switch to Non-Root User
USER $USER
ENV HOME=/home/$USER
WORKDIR /home/$USER

# Set Python Pip Packages Cache Directory
ENV PIP_CACHE_DIR=/home/$USER/.cache/pip

# Expose SSH Port
EXPOSE 22

RUN sudo mkdir /run/sshd

# Start SSH by default
CMD ["sudo /usr/sbin/sshd", "-D"]

# How to build 
# docker buildx build --rm --tag ubuntu_workserv --file .\Dockerfile .

# How to run
# On Linux Host
# docker run -it --name workserv --hostname workserv -e DISPLAY=$DISPLAY -e TERM=xterm-256color -v /tmp/.X11-unix:/tmp/.X11-unix -v ~/myWork:/home/docker/myWork ubuntu_workserv /bin/bash
# On Windows Host
# docker run -it --name workserv --hostname workserv -e DISPLAY=host.docker.internal:0 -e TERM=xterm-256color -v c:/!myWork:/home/docker/myWork ubuntu_workserv /bin/bash
# Run GUI with Build-in Xserver on Windows 11
# https://www.youtube.com/watch?v=UEre6Bd75dw
