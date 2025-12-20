#!/bin/bash
echo "========================================="
echo "     macOS Network Optimization Tool     "
echo "========================================="

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root (sudo)"
    exit 1
fi

echo ""
echo "1. Flushing DNS cache..."
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
echo "✓ DNS cache cleared"

echo ""
echo "2. Setting DNS to Cloudflare..."
networksetup -setdnsservers Wi-Fi 1.1.1.1 1.0.0.1
echo "✓ DNS set to 1.1.1.1, 1.0.0.1"

echo ""
echo "3. Optimizing TCP parameters..."
sudo sysctl -w net.inet.tcp.delayed_ack=0
sudo sysctl -w net.inet.tcp.recvspace=65536
sudo sysctl -w net.inet.tcp.sendspace=65536
sudo sysctl -w net.inet.tcp.minmss=536
sudo sysctl -w net.inet.tcp.fastopen=3
echo "✓ TCP parameters optimized"

echo ""
echo "4. Testing connection..."
echo "Ping to 1.1.1.1:"
ping -c 2 1.1.1.1 | tail -1

echo ""
echo "========================================="
echo "✅ Network optimization complete!"
echo "========================================="
echo ""
echo "Next steps:"
echo "- Run: ./scripts/network_monitor.sh"
echo "- Test speed: speedtest-cli --simple"
echo "- For full optimization: brew install mtr iftop speedtest-cli"
