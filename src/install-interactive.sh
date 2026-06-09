#!/bin/bash
echo "🚀 CleanMac Pro Interactive Dashboard Installer"
echo "=============================================="

# Check if in CleanMac-Pro directory
if [[ ! -f "./cleanmac-smart-cache" ]]; then
    echo "❌ Error: Run this from the CleanMac-Pro directory"
    exit 1
fi

# Make scripts executable
echo "🔧 Setting permissions..."
chmod +x cleanmac-* scripts/*.sh 2>/dev/null

# Install interactive dashboard
echo "📦 Installing interactive dashboard..."
sudo cp cleanmac-interactive /usr/local/bin/

# Create aliases
echo "🔗 Creating aliases..."
{
    echo ""
    echo "# CleanMac Pro Aliases"
    echo "alias cleanmac='/usr/local/bin/cleanmac-interactive'"
    echo "alias cm='cleanmac'"
    echo "alias cm-clean='./cleanmac-smart-cache'"
    echo "alias cm-analyze='./cleanmac-analyze'"
    echo "alias cm-network='sudo ./scripts/network_optimizer.sh'"
} >> ~/.zshrc

# Create default config if doesn't exist
if [[ ! -f "$HOME/.cleanmacrc" ]]; then
    echo "⚙️  Creating default config..."
    cat > "$HOME/.cleanmacrc" << CONFIGEOF
# CleanMac Pro Configuration
BACKUP_DIR="$HOME/Documents/CleanMac_Backups"
AUTO_CLEAN="weekly"
EXCLUDE_DIRS="~/Documents/Important ~/Projects"
CONFIGEOF
fi

# Create backup directory
mkdir -p "$HOME/Documents/CleanMac_Backups" 2>/dev/null

echo ""
echo "✅ Installation complete!"
echo ""
echo "Usage:"
echo "  cleanmac           - Launch interactive dashboard"
echo "  cm                 - Short alias"
echo "  cm-clean           - Quick cache clean"
echo "  cm-analyze         - Disk analysis"
echo "  cm-network         - Network optimization"
echo ""
echo "Run 'cleanmac' to get started! 🚀"
