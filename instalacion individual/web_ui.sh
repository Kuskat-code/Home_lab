#!/bin/bash
set -e
if [ "$EUID" -ne 0 ]; then
    echo "Error correlo con el sudo $0"
    exit 1
fi
TARGET_DIR="/home/open-webui-data"
docker run -d \
  -p 3000:8080 \
  -v "$TARGET_DIR:/app/backend/data" \
  --name open-webui \
  --restart always \
  ghcr.io/open-webui/open-webui:main