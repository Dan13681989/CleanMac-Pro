#!/bin/bash
echo "🏢 CleanMac Pro Enterprise - Ultimate Installation"
echo "================================================"
echo ""

# Check if running on macOS
if [ "$(uname)" != "Darwin" ]; then
    echo "❌ Error: This tool is for macOS only"
    exit 1
fi

# Check macOS version
OS_VERSION=$(sw_vers -productVersion)
echo "✅ macOS $OS_VERSION detected"

# Create installation directory
INSTALL_DIR="$HOME/CleanMac-Pro"
echo "📁 Installing to: $INSTALL_DIR"

# Download or copy files
if [ -d "$INSTALL_DIR" ]; then
    echo "🔄 Updating existing installation..."
    cd "$INSTALL_DIR"
    git pull origin main 2>/dev/null || echo "⚠️  Could not update via git"
else
    echo "📥 Creating new installation..."
    git clone https://github.com/Dan13681989/CleanMac-Pro.git "$INSTALL_DIR" 2>/dev/null || {
        echo "❌ Git clone failed, creating directory manually"
        mkdir -p "$INSTALL_DIR"
    }
fi

# Make scripts executable
chmod +x "$INSTALL_DIR"/*.sh 2>/dev/null
chmod +x "$INSTALL_DIR"/enterprise-features/*.sh 2>/dev/null

# Install system commands
echo "🔧 Installing system commands..."
sudo cp "$INSTALL_DIR/cleanmac-dashboard" /usr/local/bin/ 2>/dev/null
sudo cp "$INSTALL_DIR/enterprise-features/cleanmac-enterprise-control.sh" /usr/local/bin/cleanmac-enterprise 2>/dev/null
sudo cp "$INSTALL_DIR/install-commands.sh" /usr/local/bin/cleanmac-install 2>/dev/null

sudo chmod +x /usr/local/bin/cleanmac-* 2>/dev/null

echo ""
echo "🎉 CLEANMAC PRO ENTERPRISE INSTALLED SUCCESSFULLY!"
echo "================================================="
echo ""
echo "Available commands:"
echo "  cleanmac-dashboard     # System dashboard"
echo "  cleanmac-enterprise    # Control panel (16 options)"
echo "  cleanmac-install       # Update/reinstall"
echo ""
echo "Quick start:"
echo "  cleanmac-enterprise    # Launch the control panel"
echo ""
echo "Documentation: https://github.com/Dan13681989/CleanMac-Pro"
