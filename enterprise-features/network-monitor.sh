#!/bin/bash
echo "🌐 NETWORK MONITOR"
echo "================="

# Try multiple IP services
echo "Public IP:"
curl -s http://ipinfo.io/ip || curl -s http://ifconfig.me || echo "Unable to determine"

# Local IP
LOCAL_IP=$(ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null || echo "Not connected")
echo "Local IP: $LOCAL_IP"

# Network interfaces
echo ""
echo "📡 Network Interfaces:"
networksetup -listallhardwareports | grep "Device:" | awk '{print $2}' | while read interface; do
    status=$(ifconfig $interface 2>/dev/null | grep "status:" | awk '{print $2}' || echo "down")
    ip=$(ipconfig getifaddr $interface 2>/dev/null || echo "No IP")
    echo "  $interface: $status ($ip)"
done

# Active connections
echo ""
echo "📊 Active Connections:"
netstat -an | grep ESTABLISHED | wc -l | xargs echo "ESTABLISHED:"
netstat -an | grep LISTEN | wc -l | xargs echo "LISTENING:"
