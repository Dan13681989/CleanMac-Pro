#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Installing CleanMac Pro...${NC}"
echo ""

# Check for macOS
if [[ "$(uname)" != "Darwin" ]]; then
    echo -e "${RED}❌ Error: This script is for macOS only${NC}"
    exit 1
fi

# Create temp directory
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# Download CleanMac-Pro
echo "📥 Downloading CleanMac Pro..."
git clone --depth 1 https://github.com/Dan13681989/CleanMac-Pro.git
cd CleanMac-Pro

# Make scripts executable
echo "🔧 Making scripts executable..."
chmod +x cleanmac*
chmod +x bin/*.sh 2>/dev/null || true

# Install to /usr/local/bin
echo "📦 Installing to /usr/local/bin..."
for script in cleanmac cleanmac-dashboard cleanmac-analyze cleanmac-large-files cleanmac-smart-cache cleanmac-docker-clean cleanmac-security-scan; do
    if [ -f "$script" ]; then
        sudo cp "$script" /usr/local/bin/
        sudo chmod +x /usr/local/bin/"$script"
        echo "  ✅ Installed: $script"
    fi
done

# Clean up
cd ~
rm -rf "$TEMP_DIR"

echo ""
echo -e "${GREEN}🎉 Installation complete!${NC}"
echo ""
echo "📋 Available commands:"
echo "  cleanmac              - Main menu with all options"
echo "  cleanmac-dashboard    - System overview dashboard"
echo "  cleanmac-analyze      - Disk usage analysis"
echo "  cleanmac-large-files  - Find large files"
echo "  cleanmac-smart-cache  - Clean system caches"
echo "  cleanmac-docker-clean - Optimize Docker"
echo "  cleanmac-security-scan - Security audit"
echo ""
echo "🚀 Get started with: cleanmac --help"
