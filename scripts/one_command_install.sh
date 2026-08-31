#!/bin/bash

echo "🚀 CleanMac Pro - True One-Command Installer"
echo "==========================================="

# Download and install directly
echo "📥 Downloading and installing CleanMac Pro..."
curl -fsSL https://raw.githubusercontent.com/Dan13681989/cleanmac/main/cleanmac_pro.sh -o /tmp/cleanmac_pro.sh
chmod +x /tmp/cleanmac_pro.sh

# Install system-wide using the downloaded script
sudo cp /tmp/cleanmac_pro.sh /usr/local/bin/cleanmac
sudo chmod +x /usr/local/bin/cleanmac

# Create aliases
echo "🔧 Setting up command aliases..."
sudo tee /usr/local/bin/health-score > /dev/null << 'EOL'
#!/bin/bash
cleanmac --health-score
EOL

sudo tee /usr/local/bin/security-audit > /dev/null << 'EOL'
#!/bin/bash
cleanmac --security-audit
EOL

sudo tee /usr/local/bin/quickclean > /dev/null << 'EOL'
#!/bin/bash
cleanmac --quick-clean
EOL

sudo tee /usr/local/bin/sysinfo > /dev/null << 'EOL'
#!/bin/bash
cleanmac --sys-info
EOL

sudo chmod +x /usr/local/bin/health-score
sudo chmod +x /usr/local/bin/security-audit
sudo chmod +x /usr/local/bin/quickclean
sudo chmod +x /usr/local/bin/sysinfo

echo ""
echo "🎉 CleanMac Pro installed successfully!"
echo ""
echo "Available commands:"
echo "  health-score             # System health check"
echo "  security-audit           # Security audit"
echo "  quickclean               # Fast cleanup"
echo "  sysinfo                  # System information"
echo "  cleanmac --help          # All advanced options"
