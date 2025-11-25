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
brew install Dan13681989/tap/cleanmac-pro

echo "🎉 Installation complete!"
echo "💡 Run 'cleanmac-dashboard' to get started"
