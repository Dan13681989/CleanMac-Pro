#!/bin/bash

# CleanMac Pro Installation Script
echo "🚀 Installing CleanMac Pro..."

# Make all scripts executable
chmod +x cleanmac cleanmac-smart-cache cleanmac-docker-clean

# Create default configuration if it doesn't exist
if [ ! -f ~/.cleanmacrc ]; then
    echo "📝 Creating default configuration..."
    cat > ~/.cleanmacrc << 'CONFIGEOF'
# CleanMac Pro Configuration
CLEANMAC_BACKUP_DIR="$HOME/Documents/CleanMac_Backups"
# Add your custom paths here
CONFIGEOF
fi

# Create backup directory
mkdir -p ~/Documents/CleanMac_Backups

# Create symbolic links for easy access
sudo ln -sf "$(pwd)/cleanmac" /usr/local/bin/cleanmac 2>/dev/null || true
sudo ln -sf "$(pwd)/cleanmac-smart-cache" /usr/local/bin/cleanmac-smart-cache 2>/dev/null || true
sudo ln -sf "$(pwd)/cleanmac-docker-clean" /usr/local/bin/cleanmac-docker-clean 2>/dev/null || true

echo "✅ Installation complete!"
echo ""
echo "Available commands:"
echo "  cleanmac cache           - Clean system caches"
echo "  cleanmac docker          - Clean Docker and resize Docker.raw"
echo "  cleanmac analyze         - Analyze disk usage"
echo "  cleanmac large-files     - Find large files"
echo "  cleanmac security        - Security audit"
echo "  cleanmac dashboard       - System dashboard"
echo ""
echo "Configuration: ~/.cleanmacrc"
echo "Backup directory: ~/Documents/CleanMac_Backups"
