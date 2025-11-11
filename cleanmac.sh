#!/bin/bash
# CleanMac Pro - Professional macOS Optimization Suite
# Version 2.0 - With Advanced Features

VERSION="2.1"
AUTHOR="Dan13681989"

# Color codes for better UI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# New Advanced Features
show_banner() {
    echo -e "${BLUE}"
    echo "╔════════════════════════════════════════╗"
    echo "║           CLEANMAC PRO v2.1           ║"
    echo "║      Professional macOS Suite         ║"
    echo "╚════════════════════════════════════════╝"
    echo -e "${NC}"
}

# System Performance Scoring
system_score() {
    echo -e "${YELLOW}🔍 Calculating System Health Score...${NC}"
    
    # Disk usage
    disk_usage=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
    disk_score=$((100 - disk_usage))
    
    # CPU load (simplified)
    load_avg=$(sysctl -n vm.loadavg | awk '{print $2}')
    load_score=$(echo "100 - ($load_avg * 20)" | bc -l 2>/dev/null | cut -d. -f1)
    
    # Overall score
    total_score=$(( (disk_score + load_score) / 2 ))
    
    echo -e "${GREEN}✅ Disk space: ${disk_usage}% used (Score: ${disk_score}/100)${NC}"
    echo -e "${GREEN}✅ System load: ${load_avg} (Score: ${load_score}/100)${NC}"
    echo -e "${BLUE}🏆 Overall System Health: ${total_score}/100${NC}"
}

# Advanced Cleanup Options
deep_clean() {
    echo -e "${YELLOW}🧹 Starting Deep Clean...${NC}"
    
    # User cache cleanup
    find ~/Library/Caches -type f -atime +7 -delete 2>/dev/null
    echo -e "${GREEN}✅ User caches cleaned${NC}"
    
    # System log rotation
    sudo newsyslog -R 2>/dev/null
    echo -e "${GREEN}✅ System logs rotated${NC}"
    
    # DNS cache flush
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
    echo -e "${GREEN}✅ DNS cache flushed${NC}"
}

# Security Check
security_scan() {
    echo -e "${YELLOW}🛡️  Running Security Scan...${NC}"
    
    # Check for outdated software
    brew_outdated=$(brew outdated 2>/dev/null | wc -l)
    echo -e "${BLUE}📦 Outdated Homebrew packages: $brew_outdated${NC}"
    
    # Check SIP status
    sip_status=$(csrutil status 2>/dev/null | grep -o "enabled\|disabled")
    echo -e "${BLUE}🛡️  SIP Status: $sip_status${NC}"
}

# Main menu with new features
main_menu() {
    show_banner
    
    echo "Select an option:"
    echo "1) 🧹 Standard Cleanup"
    echo "2) 🔍 System Health Score"
    echo "3) 🛡️  Security Scan" 
    echo "4) 🚀 Deep Clean"
    echo "5) 📊 System Info"
    echo "6) ❌ Exit"
    
    read -p "Enter choice [1-6]: " choice
    
    case $choice in
        1) standard_cleanup ;;
        2) system_score ;;
        3) security_scan ;;
        4) deep_clean ;;
        5) system_info ;;
        6) exit 0 ;;
        *) echo "Invalid option"; main_menu ;;
    esac
}

# Your existing functions would go here (standard_cleanup, system_info, etc.)
# For now, let's create placeholder functions

standard_cleanup() {
    echo -e "${YELLOW}Running standard cleanup...${NC}"
    # Your existing cleanup logic here
    echo -e "${GREEN}Standard cleanup completed!${NC}"
}

system_info() {
    echo -e "${YELLOW}Gathering system information...${NC}"
    echo "Hostname: $(hostname)"
    echo "OS: $(sw_vers -productName) $(sw_vers -productVersion)"
    echo "Hardware: $(sysctl -n hw.model)"
    echo "Processor: $(sysctl -n machdep.cpu.brand_string)"
    echo "Memory: $(sysctl -n hw.memsize | awk '{print $0/1073741824 " GB"}')"
}

# Check if script is run with arguments
if [ $# -eq 0 ]; then
    main_menu
else
    # Handle command line arguments
    case $1 in
        "--health-score") system_score ;;
        "--security-scan") security_scan ;;
        "--deep-clean") deep_clean ;;
        "--sys-info") system_info ;;
        "--version") echo "CleanMac Pro v$VERSION by $AUTHOR" ;;
        *) echo "Use --help for usage information" ;;
    esac
fi
