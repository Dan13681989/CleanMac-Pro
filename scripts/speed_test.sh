#!/bin/bash
# CleanMac Pro Speed Test - Reliable Version

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🚀 Network Speed Test${NC}"
echo "========================"

# Method 1: Use curl with GitHub (most reliable)
echo -e "\n${YELLOW}Method 1: Download Test (GitHub)${NC}"
echo "Testing connection to GitHub..."

# Test 1: Small file (HTML)
start1=$(date +%s.%N)
size1=$(curl -s -o /dev/null -w "%{size_download}" https://github.com 2>/dev/null)
end1=$(date +%s.%N)

if [[ $size1 -gt 0 ]]; then
    time1=$(echo "$end1 - $start1" | bc)
    speed1=$(echo "scale=2; $size1 / $time1 / 1024" | bc)
    echo "  Small file (HTML): ${speed1} KB/s"
    
    # Test 2: Medium file (GitHub logo)
    echo "Testing medium file download..."
    start2=$(date +%s.%N)
    size2=$(curl -s -o /dev/null -w "%{size_download}" https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png 2>/dev/null)
    end2=$(date +%s.%N)
    
    if [[ $size2 -gt 0 ]]; then
        time2=$(echo "$end2 - $start2" | bc)
        speed2=$(echo "scale=2; $size2 / $time2 / 1024" | bc)
        echo "  Medium file (PNG): ${speed2} KB/s"
        
        # Calculate Mbps
        mbps=$(echo "scale=2; $speed2 * 8 / 1024" | bc)
        echo -e "\n${GREEN}✅ Approximate speed: ${mbps} Mbps${NC}"
        
        # Rating
        if (( $(echo "$mbps > 50" | bc -l) )); then
            echo "  Rating: Excellent! 🚀"
        elif (( $(echo "$mbps > 20" | bc -l) )); then
            echo "  Rating: Good 👍"
        elif (( $(echo "$mbps > 5" | bc -l) )); then
            echo "  Rating: Fair 👌"
        else
            echo "  Rating: Slow 🐌"
        fi
    fi
else
    echo -e "${RED}✗ Cannot connect to test server${NC}"
fi

# Method 2: Ping test
echo -e "\n${YELLOW}Method 2: Ping/Latency Test${NC}"
echo "Testing latency to Google DNS..."
ping -c 3 8.8.8.8 2>/dev/null | tail -2

# Method 3: Check for alternative tools
echo -e "\n${YELLOW}Alternative Speed Test Tools:${NC}"
echo "To install better speed test tools:"
echo "1. ${BLUE}npm install -g speed-test${NC} (Node.js version)"
echo "2. ${BLUE}brew install wget && wget --help${NC} (for download tests)"
echo "3. ${BLUE}Use networkquality CLI (macOS Monterey+)${NC}"

# Check for networkquality (macOS built-in)
if command -v networkquality &>/dev/null; then
    echo -e "\n${GREEN}Running macOS networkquality test...${NC}"
    networkquality
fi
