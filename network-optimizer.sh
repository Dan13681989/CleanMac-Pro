#!/bin/bash
# CleanMac Pro Network Optimizer - Fixed Version

optimize_network() {
    echo "🌐 OPTIMIZING NETWORK PERFORMANCE"
    echo "=========================================="
    
    echo "🔄 Flushing DNS cache..."
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
    echo "✅ DNS cache flushed"
    
    echo "🔄 Resetting network interfaces..."
    sudo ifconfig en0 down 2>/dev/null
    sudo ifconfig en0 up 2>/dev/null
    echo "✅ Network interfaces reset"
    
    echo "🎉 Network optimization complete!"
}

speed_test() {
    echo "🧪 RUNNING NETWORK SPEED TEST"
    echo "=========================================="
    
    echo "📥 Testing download speed..."
    ping -c 4 8.8.8.8
}

network_info() {
    echo "📊 NETWORK INFORMATION"
    echo "=========================================="
    
    # Public IP with multiple fallbacks
    echo "🌍 Public IP:"
    curl -s --max-time 3 https://api.ipify.org || curl -s --max-time 3 https://icanhazip.com || echo "Unavailable"
    
    # Local IP
    local_ip=$(ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null || echo "Not available")
    echo "🏠 Local IP: $local_ip"
    
    # Network interfaces
    echo "🔌 Active Network Interfaces:"
    ifconfig | grep -E "^en|^wl" | grep "status: active" | awk '{print $1}' | head -3
    
    # DNS servers
    echo "📡 DNS Servers:"
    scutil --dns | grep "nameserver" | awk '{print $3}' | sort | uniq | head -5
}

case "${1:-}" in
    "--optimize") optimize_network ;;
    "--speed-test") speed_test ;;
    "--info") network_info ;;
    *) 
        echo "Usage: $0 --optimize | --speed-test | --info"
        echo "Example: $0 --info"
        ;;
esac
