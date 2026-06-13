#!/bin/bash

set -e
if [ "$EUID" -ne 0 ]; then
    echo "Error correlo con el sudo $0"
    exit 1
fi
REAL_USER=${SUDO_USER:-$(whoami)}
HOME_DIR=$(eval echo ~$REAL_USER)
TARGET_DIR="" #Aqui agrega tu ruta donde se alojara el webUI
#Mi ejemplo: TARGET_DIR="/mnt/datos/open-webui-data"
mkdir -p "$TARGET_DIR"#carpeta padre
chown -R "$REAL_USER":"$REAL_USER" "$TARGET_DIR"