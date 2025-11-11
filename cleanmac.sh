#!/bin/bash

# CleanMac Pro Main Script
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BLUE='\033[0;34m'
NC='\033[0m'

show_dashboard() {
    clear
    echo -e "${CYAN}"
    echo "=========================================="
    echo "           CLEANMAC PRO v3.0"
    echo "           Main Console"
    echo "=========================================="
    echo -e "${NC}"
}

quick_clean() {
    echo -e "${YELLOW}🧹 Running quick cleanup...${NC}"
    find ~/Library/Caches -type f -atime +1 -delete 2>/dev/null
    sudo purge 2>/dev/null
    echo -e "${GREEN}✅ Quick cleanup completed!${NC}"
    read -p "Press [Enter] to continue..."
}

performance_boost() {
    echo -e "${YELLOW}🚀 Boosting performance...${NC}"
    sudo purge 2>/dev/null
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
    echo -e "${GREEN}✅ Performance boost applied!${NC}"
    read -p "Press [Enter] to continue..."
}

security_scan() {
    echo -e "${YELLOW}🛡️ Running security scan...${NC}"
    echo -e "Firewall: $(defaults read /Library/Preferences/com.apple.alf globalstate 2>/dev/null || echo 'Unknown')"
    echo -e "SIP: $(csrutil status 2>/dev/null | head -1)"
    echo -e "${GREEN}✅ Security scan completed!${NC}"
    read -p "Press [Enter] to continue..."
}

main_menu() {
    while true; do
        show_dashboard
        echo -e "${CYAN}🚀 MAIN MENU${NC}"
        echo "=========================================="
        echo "1) 🧹 Quick Clean"
        echo "2) 🚀 Performance Boost"
        echo "3) 🛡️ Security Scan"
        echo "4) 🖥️ Launch GUI Version"
        echo "5) 🔋 Battery Health"
        echo "6) 🌐 Network Tools"
        echo "7) ❌ Exit"
        echo ""
        
        read -p "Select option [1-7]: " choice
        case $choice in
            1) quick_clean ;;
            2) performance_boost ;;
            3) security_scan ;;
            4) ./cleanmac-gui.sh ;;
            5) ./battery-health.sh --check ;;
            6) ./network-optimizer.sh --info ;;
            7) 
                echo -e "${GREEN}👋 Thank you for using CleanMac Pro!${NC}"
                exit 0 
                ;;
            *) 
                echo -e "${RED}Invalid option. Please try again.${NC}"
                sleep 1
                ;;
        esac
    done
}

# Command line interface
case "${1:-}" in
    "--clean") quick_clean ;;
    "--performance") performance_boost ;;
    "--security") security_scan ;;
    "--gui") ./cleanmac-gui.sh ;;
    "--help")
        echo "CleanMac Pro v3.0 - Usage:"
        echo "  ./cleanmac.sh              # Interactive menu"
        echo "  ./cleanmac.sh --clean      # Quick cleanup"
        echo "  ./cleanmac.sh --performance # Performance boost"
        echo "  ./cleanmac.sh --security   # Security scan"
        echo "  ./cleanmac.sh --gui        # Launch GUI"
        ;;
    *) main_menu ;;
esac
