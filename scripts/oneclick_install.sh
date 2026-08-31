#!/bin/bash

echo -e "\033[1;36m"
echo "╔══════════════════════════════════════════════╗"
echo "║           CleanMac Pro One-Click Setup       ║"
echo "║           Everything in 1 Command!           ║"
echo "╚══════════════════════════════════════════════╝"
echo -e "\033[0m"

# Check if we're in the right directory
if [ ! -f "cleanmac_pro.sh" ]; then
    echo "❌ Error: Please run this from CleanMac Pro directory"
    echo "   cd /path/to/CleanMac-pro"
    exit 1
fi

# Make executable
chmod +x cleanmac_pro.sh

# Install system-wide
./cleanmac_pro.sh --install

echo ""
echo "🎉 Installation Complete! Now use these commands anywhere:"
echo ""
echo "🔧 SYSTEM CLEANING:"
echo "   cleanmac --clean           # Full system cleanup"
echo "   quickclean                 # Fast cleanup only"
echo ""
echo "📊 SYSTEM INFO:"
echo "   sysinfo                    # System overview"
echo "   cleanmac --disk-info       # Disk usage info"
echo "   health-score               # Health score (1-100)"
echo ""
echo "🛡️  SECURITY:"
echo "   security-audit             # Security audit"
echo "   cleanmac --sip-status      # Check SIP status"
echo ""
echo "💾 TIME MACHINE:"
echo "   cleanmac --tm-status       # Time Machine status"
echo "   cleanmac --tm-start        # Start backup"
echo "   cleanmac --tm-stop         # Stop backup"
echo "   cleanmac --verify-backup   # Verify backup"
echo ""
echo "💡 Tip: Use 'cleanmac --help' for all options!"
