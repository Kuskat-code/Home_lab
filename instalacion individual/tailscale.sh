#!/bin/bash
set -e #parar
curl --version
DEBIAN_CODENAME=$(lsb_release -cs 2>/dev/null || grep VERSION_CODENAME /etc/os-release | cut -d= -f2)
if [ "$EUID" -ne 0 ]; then
    echo "Error correlo con el sudo $0"
    exit 1
fi

apt-get update
apt-get install curl -y

curl -fsSL https://pkgs.tailscale.com/stable/debian/trixie.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/debian/trixie.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list

apt-get update
apt-get install tailscale -y
tailscale up
tailscale ip -4
echo "Tu ip en la vpn es: $(tailscale ip -4)"