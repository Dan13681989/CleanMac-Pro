#!/bin/bash
# CleanMac Pro Installer

echo "========================================"
echo "   CleanMac Pro Installation"
echo "========================================"

# Check if we're in the right directory
if [ ! -f "cleanmac-interactive" ]; then
    echo "ERROR: Please run from CleanMac-Pro directory"
    exit 1
fi

# Set permissions
echo "Setting permissions..."
chmod +x cleanmac-* scripts/*.sh 2>/dev/null

# Install main command
echo "Installing cleanmac command..."
sudo cp cleanmac-interactive /usr/local/bin/cleanmac 2>/dev/null

# Add alias to zshrc
echo "Adding alias to ~/.zshrc..."
if ! grep -q "alias cm=" ~/.zshrc; then
    echo "alias cm='cleanmac'" >> ~/.zshrc
fi

# Create config if doesn't exist
if [ ! -f ~/.cleanmacrc ]; then
    echo "Creating ~/.cleanmacrc..."
    echo "# CleanMac Pro Configuration" > ~/.cleanmacrc
    echo "BACKUP_DIR=\"\$HOME/Documents/CleanMac_Backups\"" >> ~/.cleanmacrc
fi

# Create backup directory
mkdir -p ~/Documents/CleanMac_Backups 2>/dev/null

echo ""
echo "✅ Installation complete!"
echo "Usage: 'cleanmac' or 'cm'"
echo "Run: source ~/.zshrc to load aliases"
