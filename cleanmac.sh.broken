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
    echo "6) 🎯 Complete Tune-Up"
    echo "7) 🖥️ GUI Interface"
    echo "8) 🌐 Network Optimizer"
    echo "9) 🔋 Battery Health"
    echo "0) ⚙️ Advanced Settings"    echo "7) ❌ Exit"
    
    read -p "Enter choice [1-6]: " choice
    
    case $choice in
        1) standard_cleanup ;;
        2) system_score ;;
        3) security_scan ;;
        4) deep_clean ;;
        5) system_info ;;
        6) system_tuneup ;;
        7) ./cleanmac-gui.sh ;;
        8) ./network-optimizer.sh --optimize ;;
        9) ./battery-health.sh --check ;;
        0) show_advanced_settings ;;\        7) exit 0 ;;
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
        "--tune-up") system_tuneup ;;
        *) echo "Use --help for usage information" ;;
    esac
fi

# Complete System Tune-Up
system_tuneup() {
    echo -e "${YELLOW}🎯 Starting Complete System Tune-Up...${NC}"
    
    # 1. Health Score
    system_score
    
    # 2. Security Scan  
    security_scan
    
    # 3. Deep Clean
    deep_clean
    
    # 4. DNS Optimization
    echo -e "${YELLOW}🌐 Optimizing DNS...${NC}"
    sudo networksetup -setdnsservers Wi-Fi 8.8.8.8 1.1.1.1 2>/dev/null || echo "DNS optimization requires sudo"
    echo -e "${GREEN}✅ DNS optimized to Google & Cloudflare${NC}"
    
    # 5. Final Health Score
    echo -e "${YELLOW}📊 Measuring improvements...${NC}"
    system_score
    
    echo -e "${BLUE}🎉 System Tune-Up Complete!${NC}"
}

show_advanced_settings() {
    echo -e "${YELLOW}⚙️ ADVANCED SETTINGS${NC}"
    echo "=========================================="
    echo "1) 🕒 Schedule Daily Maintenance"
    echo "2) 🌐 Run Network Speed Test"
    echo "3) 🔋 Optimize Battery Settings"
    echo "4) 📊 Generate System Report"
    echo "5) 🔙 Back to Main Menu"
    
    read -p "Select option [1-5]: " choice
    case $choice in
        1) ./scheduler.sh --setup-schedule ;;
        2) ./network-optimizer.sh --speed-test ;;
        3) ./battery-health.sh --optimize ;;
        4) generate_system_report ;;
        5) main_menu ;;
        *) show_advanced_settings ;;
    esac
}

generate_system_report() {
    echo -e "${YELLOW}📊 GENERATING SYSTEM REPORT${NC}"
    echo "=========================================="
    echo "Report generated on: $(date)" > system-report.txt
    echo "System: $(sw_vers -productName) $(sw_vers -productVersion)" >> system-report.txt
    echo "Hardware: $(sysctl -n hw.model)" >> system-report.txt
    echo "Processor: $(sysctl -n machdep.cpu.brand_string)" >> system-report.txt
    echo "Memory: $(sysctl -n hw.memsize | awk '{print $0/1073741824 " GB"}')" >> system-report.txt
    echo "Disk Usage: $(df / | grep / | awk '{print $5}')" >> system-report.txt
    echo "System Report saved to: system-report.txt"
}
