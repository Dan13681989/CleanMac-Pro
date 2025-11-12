#!/bin/bash
echo "🔨 BUILDING CLEANMAC PRO INSTALLER"
echo "================================="

# Create distribution directory
mkdir -p dist/cleanmac-pro

# Copy all files
cp -r enterprise-features dist/cleanmac-pro/
cp cleanmac-dashboard install-commands.sh README.md LICENSE dist/cleanmac-pro/

# Create install script
cat > dist/cleanmac-pro/install.sh << 'INSTALL_EOF'
#!/bin/bash
echo "🏢 CleanMac Pro Enterprise Installer"
echo "==================================="

# Check macOS version
if [[ $(sw_vers -productVersion | cut -d. -f1) -lt 10 ]]; then
    echo "❌ macOS 10.14 or later required"
    exit 1
fi

echo "✅ macOS version compatible"

# Install commands
echo "🔧 Installing system commands..."
sudo cp cleanmac-dashboard /usr/local/bin/
sudo cp enterprise-features/cleanmac-enterprise-control.sh /usr/local/bin/cleanmac-enterprise
sudo chmod +x /usr/local/bin/cleanmac-*

echo "🎉 Installation complete!"
echo ""
echo "Available commands:"
echo "  cleanmac-dashboard     # System dashboard"
echo "  cleanmac-enterprise    # Control panel"
echo "  cleanmac-security-scan # Security audit"
echo "  cleanmac-clean-now     # Quick cleanup"
INSTALL_EOF

chmod +x dist/cleanmac-pro/install.sh

echo "✅ Distribution package created in dist/cleanmac-pro/"
echo "📦 Ready for distribution!"
