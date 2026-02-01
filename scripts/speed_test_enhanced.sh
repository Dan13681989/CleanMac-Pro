#!/bin/bash
# Enhanced Speed Test for CleanMac Pro

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🚀 Network Speed Test${NC}"
echo "========================"

# Method 1: Try Ookla speedtest-cli
echo -e "\n${YELLOW}Method 1: Ookla Speedtest (Official)${NC}"
if command -v speedtest &>/dev/null; then
    echo "Testing with speedtest-cli..."
    # Add timeout to avoid hanging
    timeout 20 speedtest --simple 2>/dev/null && exit 0
    echo -e "${YELLOW}⚠ Ookla servers temporarily unavailable${NC}"
fi

# Method 2: Use curl with multiple test servers
echo -e "\n${YELLOW}Method 2: Download Speed Test${NC}"
echo "Testing download speed from multiple servers..."

# Test with GitHub (usually very reliable)
echo "1. GitHub.com (small file)..."
start=$(date +%s.%N)
size=$(curl -s -o /dev/null -w "%{size_download}" https://github.com 2>/dev/null)
end=$(date +%s.%N)

if [[ $size -gt 0 ]]; then
    duration=$(echo "$end - $start" | bc)
    speed_kb=$(echo "scale=2; $size / $duration / 1024" | bc)
    speed_mbps=$(echo "scale=2; $speed_kb * 8 / 1024" | bc)
    echo -e "   Speed: ${GREEN}$speed_mbps Mbps${NC} ($speed_kb KB/s)"
else
    echo -e "   ${RED}Failed to connect${NC}"
fi

# Method 3: Use Apple's networkquality tool (macOS Monterey+)
echo -e "\n${YELLOW}Method 3: Apple Network Quality${NC}"
if command -v networkquality &>/dev/null; then
    echo "Running Apple's networkquality test..."
    networkquality
else
    echo "Available on macOS Monterey and later."
    echo "Run: ${YELLOW}softwareupdate --all --install${NC} to update"
fi

# Method 4: Simple ping test
echo -e "\n${YELLOW}Method 4: Latency Test${NC}"
echo "Pinging Google DNS (8.8.8.8)..."
ping -c 3 8.8.8.8 2>/dev/null | tail -2

echo -e "\n${GREEN}✅ Speed test complete!${NC}"
echo "Note: Ookla servers may be temporarily down."
echo "Try again later or use the alternative methods above."
