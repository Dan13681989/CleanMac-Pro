#!/bin/bash
echo "🏢 CleanMac Pro Enterprise Installation"
echo "======================================"

# Check if running on macOS
if [ "$(uname)" != "Darwin" ]; then
    echo "❌ This script only works on macOS"
    exit 1
fi

# Create necessary directories
mkdir -p ~/.cleanmac/{analytics,remote,logs}

# Copy scripts to proper locations
echo "📦 Installing enterprise features..."
cp -r enterprise-features/* ~/ 2>/dev/null || true

# Make scripts executable
chmod +x enterprise-features/*.sh
chmod +x *.sh

# Create symlinks for global access
ln -sf ~/CleanMac-Pro/enterprise-features/cleanmac-enterprise-control.sh /usr/local/bin/cleanmac-enterprise 2>/dev/null || true
ln -sf ~/CleanMac-Pro/enterprise-features/cleanmac-enterprise-dashboard.sh /usr/local/bin/cleanmac-dashboard 2>/dev/null || true

echo "✅ Installation complete!"
echo "🚀 Usage: cleanmac-enterprise"
