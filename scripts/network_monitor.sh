#!/bin/bash
# CleanMac Pro Network Monitor
# Usage: ./scripts/network_monitor.sh [--speed-test]

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

show_network_info() {
    echo -e "${BLUE}🌐 NETWORK INFORMATION${NC}"
    echo "----------------------------------------"
    
    # Get IP address (primary interface)
    ip_address=$(ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null || echo "Not connected")
    echo -e "📡 IP Address: ${GREEN}$ip_address${NC}"
    
    # Get router/gateway
    gateway=$(netstat -nr | grep default | head -1 | awk '{print $2}')
    echo -e "🔄 Gateway: ${YELLOW}$gateway${NC}"
    
    # Get DNS servers
    dns_servers=$(scutil --dns | grep 'nameserver\[[0-9]*\]' | head -3 | awk '{print $3}' | tr '\n' ', ' | sed 's/, $//')
    echo -e "🔗 DNS Servers: ${GREEN}$dns_servers${NC}"
    
    # Check internet connectivity
    echo -ne "🌐 Internet: "
    if ping -c 1 -t 2 8.8.8.8 &>/dev/null; then
        echo -e "${GREEN}Connected ✓${NC}"
    else
        echo -e "${RED}Disconnected ✗${NC}"
    fi
}

run_speed_test() {
    echo -e "\n${YELLOW}🚀 RUNNING SPEED TEST${NC}"
    echo "----------------------------------------"
    
    # Check for speedtest-cli (Ookla)
    if command -v speedtest &>/dev/null; then
        echo "Using speedtest-cli (Ookla)..."
        speedtest --simple --no-upload 2>/dev/null || \
        speedtest --simple 2>/dev/null || \
        echo "Speed test failed. Try: brew upgrade speedtest-cli"
    
    # Check for fast-cli (Netflix)
    elif command -v fast &>/dev/null; then
        echo "Using fast-cli (Netflix)..."
        fast --upload --single-line
    
    # Check for curl fallback
    elif command -v curl &>/dev/null; then
        echo "Using curl for basic test..."
        echo "Download speed (approx):"
        # Simple download test
        start_time=$(date +%s)
        curl -s -o /dev/null https://github.com 2>/dev/null
        end_time=$(date +%s)
        download_time=$((end_time - start_time))
        if [[ $download_time -lt 3 ]]; then
            echo "  Very Fast (< 3 seconds)"
        elif [[ $download_time -lt 10 ]]; then
            echo "  Fast ($download_time seconds)"
        else
            echo "  Slow ($download_time seconds)"
        fi
    else
        echo -e "${RED}No speed test tools found!${NC}"
        echo ""
        echo "To install speed test tools:"
        echo "  ${YELLOW}brew install speedtest-cli${NC}  (Ookla Speedtest)"
        echo "  ${YELLOW}npm install -g fast-cli${NC}      (Netflix Fast.com)"
        echo ""
        echo "Or install with:"
        echo "  ${YELLOW}sudo ./scripts/network_optimizer.sh${NC} (includes basic test)"
    fi
}

# Check for --speed-test argument
if [[ "$1" == "--speed-test" ]] || [[ "$1" == "-s" ]]; then
    run_speed_test
elif [[ "$1" == "--quick" ]] || [[ "$1" == "-q" ]]; then
    echo -e "Network: ${GREEN}$(ping -c 1 -t 2 8.8.8.8 &>/dev/null && echo "Connected" || echo "Disconnected")${NC}"
else
    show_network_info
    echo ""
    echo "For speed test: ${YELLOW}./scripts/network_monitor.sh --speed-test${NC}"
    echo "Quick status:    ${YELLOW}./scripts/network_monitor.sh --quick${NC}"
fi
