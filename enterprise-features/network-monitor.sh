#!/bin/bash
echo "🌐 NETWORK MONITOR"
echo "================="
echo "Public IP: $(curl -s ifconfig.me)"
echo "Local IP: $(ipconfig getifaddr en0 2>/dev/null || echo "Not connected")"
echo "Active Connections: $(netstat -an | grep ESTABLISHED | wc -l)"
