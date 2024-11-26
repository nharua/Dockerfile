# Ubuntu Development Docker Image

## Overview

This Dockerfile creates a comprehensive Ubuntu 22.04 development environment with multiple tools and utilities, designed for a flexible and feature-rich development workspace.

## Image Features

### Base Configuration
- **Base Image**: Ubuntu 22.04
- **Timezone**: Asia/Ho_Chi_Minh
- **Locale**: C.UTF-8 for consistent encoding
- **User**: Custom docker user with sudo privileges

### Installed Software
- Version Control: Git
- Build Tools: gcc, g++, make
- Libraries: 
  - Boost
  - OpenSSL
  - C++ REST SDK
- Development Utilities:
  - Neovim (latest version)
  - Python 3
  - Node.js
  - tmux
- GUI Tools:
  - Nautilus
  - Meld
  - vim-gtk3
- Productivity Tools:
  - ripgrep
  - fd-find
  - ImageMagick
- Remote Access: OpenSSH Server

## Build Instructions

### Build the Docker Image
```bash
docker buildx build --rm --tag ubuntu_workserv --file ./Dockerfile .
```

## Run Instructions

### Linux Host
```bash
docker run -it --name workserv --hostname workserv \
    -e DISPLAY=$DISPLAY \
    -e TERM=xterm-256color \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ~/myWork:/home/docker/myWork \
    ubuntu_workserv /bin/bash
```

### Windows Host
```bash
docker run -it --name workserv --hostname workserv \
    -e DISPLAY=host.docker.internal:0 \
    -e TERM=xterm-256color \
    -v c:/!myWork:/home/docker/myWork \
    ubuntu_workserv /bin/bash
```

## Default Credentials
- **Username**: docker
- **Password**: pass@123

## Notes
- Requires X11 forwarding for GUI applications
- Volume mounts allow persistent storage and work synchronization
- Sudo access is provided without password prompt

## Windows GUI Setup
For Windows 11 GUI support, refer to this [Tutorial Video](https://www.youtube.com/watch?v=UEre6Bd75dw)

## Customization
Feel free to modify the Dockerfile to add or remove packages based on your specific development needs.

## License
Licensed under teh **BSD 3-Clause**
