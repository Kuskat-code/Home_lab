#!/bin/bash

set -e
if [ "$EUID" -ne 0 ]; then
    echo "Error correlo con el sudo $0"
    exit 1
fi
REAL_USER=${SUDO_USER:-$(whoami)}
apt-get update -y
apt-get install ca-certificates curl -y

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc 
DEBIAN_CODENAME=$(lsb_release -cs 2>/dev/null || grep VERSION_CODENAME /etc/os-release | cut -d= -f2)
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian ${DEBIAN_CODENAME} stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
usermod -aG docker "$REAL_USER"

apt update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
