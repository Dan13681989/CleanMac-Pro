#!/bin/bash
echo "🔧 Fixing CleanMac Pro Path Issues"
echo "================================="

PROJECT_DIR="$HOME/CleanMac-Pro"

# Update the control panel with absolute paths
echo "📝 Updating control panel paths..."
sudo tee /usr/local/bin/cleanmac-enterprise > /dev/null << 'SCRIPT_EOF'
#!/bin/bash
PROJECT_DIR="$HOME/CleanMac-Pro"
cd "$PROJECT_DIR"
./enterprise-features/cleanmac-enterprise-control.sh
SCRIPT_EOF

sudo chmod +x /usr/local/bin/cleanmac-enterprise

# Reinstall other commands
echo "🔄 Reinstalling system commands..."
sudo cp "$PROJECT_DIR/cleanmac-dashboard" /usr/local/bin/ 2>/dev/null
sudo chmod +x /usr/local/bin/cleanmac-*

echo "✅ Path issues fixed!"
echo "🎯 Control panel now uses absolute paths to find all scripts"
