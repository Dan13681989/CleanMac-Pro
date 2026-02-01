#!/bin/bash
echo "Setting up CleanMac-Pro Network Optimization..."
echo ""

# Make scripts executable
chmod +x scripts/*.sh

# Test the optimizer (will ask for password)
echo "Testing network optimizer..."
sudo ./scripts/network_optimizer.sh

echo ""
echo "Testing system cleanup..."
./scripts/system_cleanup.sh

echo ""
echo "Testing network monitor..."
./scripts/network_monitor.sh

echo ""
echo "========================================="
echo "✅ Setup complete!"
echo "========================================="
echo ""
echo "Your CleanMac-Pro now includes:"
echo "1. network_optimizer.sh - Optimizes DNS and TCP"
echo "2. system_cleanup.sh - Cleans caches and downloads"
echo "3. network_monitor.sh - Monitors network status"
echo ""
echo "To push to GitHub:"
echo "cd ~/CleanMac-Pro"
echo "git add ."
echo "git commit -m 'Add network optimization tools'"
echo "git push origin main"
