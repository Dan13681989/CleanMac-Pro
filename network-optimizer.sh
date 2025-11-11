#!/bin/bash
# CleanMac Pro Network Optimizer

optimize_network() {
    echo "🌐 OPTIMIZING NETWORK PERFORMANCE"
    echo "=========================================="
    
    # Flush DNS cache
    echo -e "${YELLOW}🔄 Flushing DNS cache...${NC}"
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
    echo -e "${GREEN}✅ DNS cache flushed${NC}"
    
    # Reset network interfaces
    echo -e "${YELLOW}🔄 Resetting network interfaces...${NC}"
    sudo ifconfig en0 down
    sudo ifconfig en0 up
    echo -e "${GREEN}✅ Network interfaces reset${NC}"
    
    # Optimize TCP settings
    echo -e "${YELLOW}⚡ Optimizing TCP settings...${NC}"
    sudo sysctl -w net.inet.tcp.delayed_ack=0
    sudo sysctl -w net.inet.tcp.mssdflt=1440
    echo -e "${GREEN}✅ TCP settings optimized${NC}"
    
    # Clean network caches
    echo -e "${YELLOW}🧹 Cleaning network caches...${NC}"
    sudo rm -rf /Library/Preferences/SystemConfiguration/com.apple.network.identification.plist
    sudo rm -rf /Library/Preferences/SystemConfiguration/NetworkInterfaces.plist
    echo -e "${GREEN}✅ Network caches cleaned${NC}"
    
    echo -e "${BLUE}🎉 Network optimization complete!${NC}"
}

speed_test() {
    echo "🧪 RUNNING NETWORK SPEED TEST"
    echo "=========================================="
    
    # Simple speed test using curl
    echo -e "${YELLOW}📥 Testing download speed...${NC}"
    start_time=$(date +%s)
    curl -o /dev/null -s https://speedtest.tele2.net/1GB.zip &
    curl_pid=$!
    
    # Show progress
    while ps -p $curl_pid > /dev/null; do
        echo -n "."
        sleep 1
    done
    echo ""
    
    end_time=$(date +%s)
    duration=$((end_time - start_time))
    echo -e "${GREEN}✅ Download test completed in ${duration} seconds${NC}"
}

network_info() {
    echo "📊 NETWORK INFORMATION"
    echo "=========================================="
    
    # IP addresses
    echo -e "${CYAN}🌍 Public IP:${NC} $(curl -s ifconfig.me)"
    echo -e "${CYAN}🏠 Local IP:${NC} $(ipconfig getifaddr en0)"
    
    # Network interfaces
    echo -e "${CYAN}🔌 Network Interfaces:${NC}"
    ifconfig | grep -E "^en|^wl" | grep -v "status" | awk '{print $1}'
    
    # DNS servers
    echo -e "${CYAN}📡 DNS Servers:${NC}"
    scutil --dns | grep "nameserver" | awk '{print $3}' | sort | uniq
}

case "${1:-}" in
    "--optimize") optimize_network ;;
    "--speed-test") speed_test ;;
    "--info") network_info ;;
    *) echo "Usage: $0 --optimize | --speed-test | --info" ;;
esac
