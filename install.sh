#!/bin/bash
echo "🚀 Installing CleanMac Pro..."

# Download the main script directly
sudo curl -fsSL https://raw.githubusercontent.com/Dan13681989/CleanMac-Pro/main/cleanmac.sh -o /usr/local/bin/cleanmac
sudo chmod +x /usr/local/bin/cleanmac

echo "✅ Installation complete! Run 'cleanmac --help' to get started."
