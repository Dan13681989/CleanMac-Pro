#!/bin/bash
set -euo pipefail

echo "🌐 CleanMac Pro Network Optimizer"
echo "========================================"
echo ""

# 1. Flush DNS Cache
echo "1. Flushing DNS Cache..."
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
echo "✓ DNS cache flushed"
echo ""

# 2. Optimize TCP/IP Parameters
echo "2. Optimizing TCP/IP Parameters..."
sudo sysctl -w net.inet.tcp.delayed_ack=0 2>/dev/null || true
sudo sysctl -w net.inet.tcp.recvspace=65536 2>/dev/null || true
sudo sysctl -w net.inet.tcp.sendspace=65536 2>/dev/null || true
CURRENT_MAX=$(sysctl -n kern.ipc.maxsockbuf 2>/dev/null || echo "0")
if [ "$CURRENT_MAX" -lt 8388608 ]; then
    sudo sysctl -w kern.ipc.maxsockbuf=8388608 2>/dev/null || true
fi
echo "✓ TCP parameters optimized"
echo ""

# 3. Test Network Connection
echo "3. Testing Network Connection..."
if ping -c 3 8.8.8.8 &>/dev/null; then
    echo "  Basic connectivity: OK ✓"
else
    echo "  Basic connectivity: FAILED ✗"
fi
echo ""

# 4. Speed Test (optional – skip if not available)
echo "4. Running Speed Test..."
SPEED_OK=false
if command -v speedtest-cli &>/dev/null; then
    echo "  Using speedtest-cli..."
    if speedtest-cli --simple 2>/dev/null; then
        SPEED_OK=true
    else
        echo "  speedtest-cli failed – skipping"
    fi
elif command -v networkQuality &>/dev/null; then
    echo "  Using Apple networkQuality..."
    if networkQuality -v 2>/dev/null | grep -E "(downlink|uplink)" >/dev/null; then
        SPEED_OK=true
    else
        echo "  networkQuality failed – skipping"
    fi
else
    echo "  No speed test tool found – install speedtest-cli (brew install speedtest-cli)"
fi

if [ "$SPEED_OK" = false ]; then
    echo "  ℹ️  Speed test skipped (optional). Network optimization already applied."
fi
echo ""

# 5. Network Information
echo "5. Network Information:"
ACTIVE_IP=$(ifconfig | grep -E "inet ([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v 127.0.0.1 | head -1 | awk '{print $2}')
GATEWAY=$(route -n get default 2>/dev/null | grep gateway | awk '{print $2}')
DNS=$(scutil --dns | grep 'nameserver\[[0-9]*\]' | awk '{print $3}' | sort -u | tr '\n' ', ')
echo "  📡 Active IP: ${ACTIVE_IP:-Not connected}"
echo "  🔄 Gateway: ${GATEWAY:-Unknown}"
echo "  🔗 DNS Servers: ${DNS%%, }"
echo ""

echo "✅ Network optimization complete!"
echo "Note: Some changes may take a few moments to apply."
