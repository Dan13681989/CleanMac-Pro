#!/bin/bash
echo "🔧 Installing CleanMac Pro Enterprise Commands..."

# Create command directory if it doesn't exist
sudo mkdir -p /usr/local/bin

# Install all enterprise commands
sudo tee /usr/local/bin/cleanmac-enterprise > /dev/null << 'CMDEOF'
#!/bin/bash
cd ~/CleanMac-Pro
./enterprise-features/cleanmac-enterprise-control.sh
CMDEOF

sudo tee /usr/local/bin/cleanmac-dashboard > /dev/null << 'CMDEOF'
#!/bin/bash
cd ~/CleanMac-Pro
./cleanmac-dashboard
CMDEOF

sudo tee /usr/local/bin/cleanmac-security-scan > /dev/null << 'CMDEOF'
#!/bin/bash
cd ~/CleanMac-Pro
./enterprise-features/cleanmac-enterprise-control.sh 7
CMDEOF

sudo tee /usr/local/bin/cleanmac-clean-now > /dev/null << 'CMDEOF'
#!/bin/bash
cd ~/CleanMac-Pro
./enterprise-features/cleanmac-enterprise-control.sh 6
CMDEOF

sudo tee /usr/local/bin/cleanmac-clean > /dev/null << 'CMDEOF'
#!/bin/bash
cd ~/CleanMac-Pro
./enterprise-features/cleanmac-enterprise-control.sh 6
CMDEOF

# Make all commands executable
sudo chmod +x /usr/local/bin/cleanmac-*
sudo chmod +x ~/CleanMac-Pro/enterprise-features/*.sh
sudo chmod +x ~/CleanMac-Pro/cleanmac-dashboard

echo "✅ All commands installed successfully!"
echo ""
echo "Available commands:"
echo "• cleanmac-enterprise    - Full control panel"
echo "• cleanmac-dashboard     - System dashboard"
echo "• cleanmac-security-scan - Security audit"
echo "• cleanmac-clean-now     - Quick cleanup"
echo "• cleanmac-clean         - Quick cleanup (alias)"
