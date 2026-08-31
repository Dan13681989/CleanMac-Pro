#!/bin/bash

echo "🚀 CleanMac Pro - Complete Installation"
echo "======================================"

# Make sure we're in the right directory
if [ ! -f "cleanmac_pro.sh" ]; then
    echo "❌ Error: cleanmac_pro.sh not found"
    echo "Please run this from the CleanMac Pro directory"
    exit 1
fi

# Make executable
chmod +x cleanmac_pro.sh

# Install system-wide
echo "Installing CleanMac Pro..."
./cleanmac_pro.sh --install

echo ""
echo "🎉 Installation Complete!"
echo ""
echo "Now you can use these commands anywhere:"
echo "  cleanmac --help          # All options"
echo "  health-score             # System health check"
echo "  security-audit           # Security audit"
echo "  quickclean               # Fast cleanup"
echo "  sysinfo                  # System information"
echo ""
echo "💡 Tip: Open a new terminal window for the commands to work!"
