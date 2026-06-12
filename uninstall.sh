#!/bin/bash
set -euo pipefail
echo "Removing CleanMac Pro..."
sudo rm -f /usr/local/bin/cleanmac
sudo rm -rf /usr/local/opt/cleanmac-pro
sudo rm -rf /usr/local/Cellar/cleanmac-pro
echo "Uninstall complete."
