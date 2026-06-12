#!/bin/bash
set -euo pipefail

echo "🌐 NETWORK INFORMATION"
echo "----------------------------------------"

# Get local IP using same method as cleanmac network status
LOCAL_IP=$(ifconfig | grep -E "inet ([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v 127.0.0.1 | head -1 | awk '{print $2}')
if [ -z "$LOCAL_IP" ]; then
    LOCAL_IP="Not connected"
fi
echo "📡 IP Address: $LOCAL_IP"

# Get gateway
GATEWAY=$(route -n get default 2>/dev/null | grep gateway | awk '{print $2}')
if [ -z "$GATEWAY" ]; then
    GATEWAY="Not found"
fi
echo "🔄 Gateway: $GATEWAY"

# Get DNS servers
DNS=$(scutil --dns | grep 'nameserver\[[0-9]*\]' | awk '{print $3}' | sort -u | tr '\n' ',')
DNS=${DNS%,}
echo "🔗 DNS Servers: $DNS"

# Internet connectivity
if ping -c 1 8.8.8.8 &>/dev/null; then
    echo "🌐 Internet: Connected ✓"
else
    echo "🌐 Internet: Disconnected ✗"
fi

echo ""
echo "For speed test: $0 --speed-test"
echo "Quick status:    $0 --quick"
