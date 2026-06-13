#!/bin/bash

set -e
if [ "$EUID" -ne 0 ]; then
    echo "Error correlo con el sudo $0"
    exit 1
fi
curl -fsSL https://ollama.com/install.sh | sh
mkdir -p /etc/systemd/system/ollama.service.d
echo -e "[Service]\nEnvironment=\"OLLAMA_HOST=0.0.0.0\"" > /etc/systemd/system/ollama.service.d/override.conf
systemctl daemon-reload
systemctl restart ollama
ollama pull qwen2.5-coder:3b
