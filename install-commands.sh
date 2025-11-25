#!/bin/bash
# CleanMac Pro - Command Installation
# Enhanced with advanced disk analysis features

set -e

echo "🔧 Installing CleanMac Pro Enterprise Commands..."
echo "================================================"

# Check if running as root for system-wide install
if [ "$EUID" -ne 0 ]; then
    echo "🔐 Requesting sudo permissions for system-wide installation..."
    sudo -v
fi

# Create installation directory
INSTALL_DIR="/usr/local/bin"
echo "📁 Installing to: $INSTALL_DIR"

# Install ncdu for advanced analysis
if ! command -v ncdu &> /dev/null; then
    echo "📦 Installing ncdu for advanced disk analysis..."
    brew install ncdu
fi

echo ""
echo "🚀 Installing enhanced CleanMac Pro features..."
echo "=============================================="

# Install main commands
COMMANDS=(
    "cleanmac-dashboard"
    "cleanmac-enterprise" 
    "cleanmac-security-scan"
    "cleanmac-clean-now"
    "cleanmac-analyze"
    "cleanmac-large-files"
    "cleanmac-docker-clean"
    "cleanmac-smart-cache"
)

for cmd in "${COMMANDS[@]}"; do
    if [ -f "$cmd" ]; then
        echo "📦 Installing $cmd..."
        sudo cp "$cmd" "$INSTALL_DIR/"
        sudo chmod +x "$INSTALL_DIR/$cmd"
    else
        echo "⚠️  Warning: $cmd not found in current directory"
    fi
done

# Create cleanmac-clean alias
if [ ! -f "$INSTALL_DIR/cleanmac-clean" ]; then
    sudo ln -sf "$INSTALL_DIR/cleanmac-clean-now" "$INSTALL_DIR/cleanmac-clean" 2>/dev/null || true
fi

echo ""
echo "✅ Enhanced features installed!"
echo "=============================="

echo ""
echo "🎯 NEW COMMANDS AVAILABLE:"
echo "   cleanmac-analyze       - Interactive disk analysis"
echo "   cleanmac-large-files   - Find large files"
echo "   cleanmac-docker-clean  - Optimize Docker space" 
echo "   cleanmac-smart-cache   - Intelligent cache cleaning"
echo ""
echo "🔧 LEGACY COMMANDS:"
echo "   cleanmac-enterprise    - Full control panel"
echo "   cleanmac-dashboard     - System dashboard"
echo "   cleanmac-security-scan - Security audit"
echo "   cleanmac-clean-now     - Quick cleanup"
echo "   cleanmac-clean         - Quick cleanup (alias)"

echo ""
echo "💡 Get started:"
echo "   Run 'cleanmac-dashboard' for system overview"
echo "   Run 'cleanmac-analyze' to explore disk usage"
echo ""
