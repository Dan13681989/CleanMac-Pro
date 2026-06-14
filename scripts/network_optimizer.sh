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

# 2. Restart Active Network Services
echo "2. Restarting Active Network Services..."
# Find primary active network service by checking for a valid IP
ACTIVE_SERVICE=""
for SERVICE in $(networksetup -listallnetworkservices | grep -v "An asterisk" | tail -n +2); do
    # Trim whitespace
    SERVICE=$(echo "$SERVICE" | xargs)
    IP=$(networksetup -getinfo "$SERVICE" 2>/dev/null | grep "IP address:" | awk '{print $3}')
    if [ -n "$IP" ] && [ "$IP" != "none" ]; then
        ACTIVE_SERVICE="$SERVICE"
        break
    fi
done

if [ -n "$ACTIVE_SERVICE" ]; then
    echo "  Restarting: $ACTIVE_SERVICE"
    # Disable and enable the service (ignore errors)
    sudo networksetup -setnetworkserviceenabled "$ACTIVE_SERVICE" off 2>/dev/null
    sleep 1
    sudo networksetup -setnetworkserviceenabled "$ACTIVE_SERVICE" on 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "✓ $ACTIVE_SERVICE restarted"
    else
        echo "⚠️  Could not restart $ACTIVE_SERVICE (may require admin or be disabled)"
    fi
else
    echo "⚠️  No active network service found"
fi
echo ""

# 3. Optimize TCP/IP Parameters
echo "3. Optimizing TCP/IP Parameters..."
sudo sysctl -w net.inet.tcp.delayed_ack=0 2>/dev/null || true
sudo sysctl -w net.inet.tcp.recvspace=65536 2>/dev/null || true
sudo sysctl -w net.inet.tcp.sendspace=65536 2>/dev/null || true
CURRENT_MAX=$(sysctl -n kern.ipc.maxsockbuf 2>/dev/null || echo "0")
if [ "$CURRENT_MAX" -lt 8388608 ]; then
    sudo sysctl -w kern.ipc.maxsockbuf=8388608 2>/dev/null || true
fi
echo "✓ TCP parameters optimized"
echo ""

# 4. Test Network Connection
echo "4. Testing Network Connection..."
if ping -c 3 8.8.8.8 &>/dev/null; then
    echo "  Basic connectivity: OK ✓"
else
    echo "  Basic connectivity: FAILED ✗"
fi
echo ""

# 5. Speed Test (optional)
echo "5. Running Speed Test..."
if command -v speedtest-cli &>/dev/null; then
    echo "  Using Ookla speedtest-cli..."
    speedtest-cli --simple 2>/dev/null || echo "  Speed test failed (temporary issue)"
elif command -v networkQuality &>/dev/null; then
    echo "  Using Apple networkQuality (macOS 13+)..."
    networkQuality -v 2>/dev/null | grep -E "(downlink|uplink)" | head -2 || echo "  Speed test failed"
else
    echo "  Speed test not available. Install with: brew install speedtest-cli"
    echo "  Or use Apple's networkQuality (built-in on macOS 13+)."
fi
echo ""

# 6. Network Information
echo "6. Network Information:"
ACTIVE_IP=$(ifconfig | grep -E "inet ([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v 127.0.0.1 | head -1 | awk '{print $2}')
GATEWAY=$(route -n get default 2>/dev/null | grep gateway | awk '{print $2}')
DNS=$(scutil --dns | grep 'nameserver\[[0-9]*\]' | awk '{print $3}' | sort -u | tr '\n' ', ')
echo "  📡 Active IP: ${ACTIVE_IP:-Not connected}"
echo "  🔄 Gateway: ${GATEWAY:-Unknown}"
echo "  🔗 DNS Servers: ${DNS%%, }"
echo ""

echo "✅ Network optimization complete!"
echo "Note: Some network changes may take a few moments to apply."
