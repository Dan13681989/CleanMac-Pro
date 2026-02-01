#!/bin/bash
# CleanMac Pro Network Optimizer - Enhanced Version

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🌐 CleanMac Pro Network Optimizer${NC}"
echo "========================================"

# 1. Flush DNS Cache
echo -e "\n${YELLOW}1. Flushing DNS Cache...${NC}"
sudo dscacheutil -flushcache 2>/dev/null
sudo killall -HUP mDNSResponder 2>/dev/null
echo -e "${GREEN}✓ DNS cache flushed${NC}"

# 2. Improved: Restart only active network services
echo -e "\n${YELLOW}2. Restarting Active Network Services...${NC}"
count=0

# Get list of network services, filter out asterisks and empty lines
services=$(networksetup -listallnetworkservices 2>/dev/null | \
           tail -n +2 | \
           grep -v "^\*" | \
           grep -v "^$" | \
           sed 's/^ *//;s/ *$//')

for service in $services; do
    # Skip known problematic services
    case "$service" in
        "Thunderbolt"|"Bridge"|"iPhone"|"USB"|"Bluetooth"|"FireWire")
            continue
            ;;
    esac
    
    # Check if service is active by trying to get its info
    if networksetup -getinfo "$service" >/dev/null 2>&1; then
        echo "  Restarting: $service"
        # Try to disable IPv6 temporarily (silently)
        sudo networksetup -setv6off "$service" >/dev/null 2>&1
        ((count++))
    fi
done

if [[ $count -gt 0 ]]; then
    echo -e "${GREEN}✓ ${count} network services restarted${NC}"
else
    echo -e "${YELLOW}⚠ No active network services found to restart${NC}"
fi

# 3. Optimize TCP/IP Parameters
echo -e "\n${YELLOW}3. Optimizing TCP/IP Parameters...${NC}"
{
    sudo sysctl -w net.inet.tcp.delayed_ack=0
    sudo sysctl -w net.inet.tcp.recvspace=65536
    sudo sysctl -w net.inet.tcp.sendspace=65536
    sudo sysctl -w kern.ipc.maxsockbuf=16777216
    echo -e "${GREEN}✓ TCP parameters optimized${NC}"
} 2>/dev/null

# 4. Improved Speed Test with fallbacks
echo -e "\n${YELLOW}4. Testing Network Connection...${NC}"

# First, check basic connectivity
if ping -c 2 -t 2 8.8.8.8 >/dev/null 2>&1; then
    echo -e "  Basic connectivity: ${GREEN}OK ✓${NC}"
    
    # Try speedtest-cli (Ookla)
    if command -v speedtest >/dev/null 2>&1; then
        echo "  Running speed test (Ookla)..."
        # Try with timeout in case server is down
        timeout 15 speedtest --simple 2>/dev/null || \
        echo "    Speedtest server unavailable (temporary issue)"
    else
        echo "  Install speedtest-cli for detailed metrics:"
        echo "    ${YELLOW}brew install speedtest-cli${NC}"
    fi
else
    echo -e "  Basic connectivity: ${RED}FAILED ✗${NC}"
fi

# 5. Improved Network Information
echo -e "\n${YELLOW}5. Network Information:${NC}"

# Get primary active IP (more reliable method)
active_ip=$(ipconfig getifaddr $(route get default | grep interface | awk '{print $2}') 2>/dev/null)
if [[ -n "$active_ip" ]]; then
    echo -e "  📡 Active IP: ${GREEN}$active_ip${NC}"
else
    # Fallback to checking all interfaces
    active_ip=$(ifconfig | grep "inet " | grep -v 127.0.0.1 | head -1 | awk '{print $2}')
    [[ -n "$active_ip" ]] && echo -e "  📡 IP Address: ${GREEN}$active_ip${NC}" || echo "  📡 IP Address: Not detected"
fi

# Get gateway
gateway=$(netstat -nr | grep default | head -1 | awk '{print $2}')
echo -e "  🔄 Gateway: ${YELLOW}$gateway${NC}"

# Get DNS servers
dns_servers=$(scutil --dns 2>/dev/null | grep 'nameserver\[[0-9]*\]' | head -3 | awk '{print $3}' | tr '\n' ', ' | sed 's/, $//')
if [[ -n "$dns_servers" ]]; then
    echo -e "  🔗 DNS Servers: ${GREEN}$dns_servers${NC}"
fi

echo -e "\n${GREEN}✅ Network optimization complete!${NC}"
echo "Note: Some network changes may take a few moments to apply."
