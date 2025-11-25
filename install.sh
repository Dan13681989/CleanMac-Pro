#!/bin/bash
echo "🚀 Installing CleanMac Pro Enterprise..."
echo "📦 This will install:"
echo "   • cleanmac-dashboard     - System overview"
echo "   • cleanmac-analyze       - Disk analysis"
echo "   • cleanmac-large-files   - Space hog finder"
echo "   • cleanmac-smart-cache   - Cache cleaning"
echo "   • cleanmac-docker-clean  - Docker optimization"

# Check for Homebrew
if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew required. Install from: https://brew.sh"
    exit 1
fi

# Install via Homebrew
echo "📥 Installing via Homebrew..."
brew install Dan13681989/tap/cleanmac-pro

if [ $? -eq 0 ]; then
    echo "🎉 Installation complete!"
    echo "💡 Run 'cleanmac-dashboard' to get started"
else
    echo "❌ Installation failed. Trying alternative method..."
    
    # Alternative: manual installation
    echo "📥 Trying manual installation..."
    sudo cp bin/* /usr/local/bin/
    echo "🎉 Manual installation complete!"
    echo "💡 Run 'cleanmac-dashboard' to get started"
fi
