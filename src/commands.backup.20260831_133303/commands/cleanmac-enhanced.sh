#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../lib/common.sh"

# CleanMac Pro Enhanced v4.0
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

show_dashboard() {
    clear
    echo -e "${PURPLE}"
    echo "=========================================="
    echo "        CLEANMAC PRO ENHANCED v4.0"
    echo "        AI-Powered macOS Suite"
    echo "=========================================="
    echo -e "${NC}"
    
    # Live AI-powered insights
    echo -e "${CYAN}🤖 AI SYSTEM INSIGHTS${NC}"
    echo "=========================================="
    
    # Smart system analysis
    cpu_usage=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | sed 's/%//')
    memory_free=$(memory_pressure 2>/dev/null | grep "System-wide memory free percentage:" | awk '{print $5}' | tr -d '%')
    
    echo -e "🖥️  CPU: ${cpu_usage}%"
    echo -e "🧠 Memory Free: ${memory_free}%"
    
    # AI recommendations
    if [ $(echo "$cpu_usage > 70" | bc -l) -eq 1 ]; then
        echo -e "🎯 AI Tip: ${YELLOW}High CPU - Try performance boost${NC}"
    elif [ "$memory_free" -lt 20 ]; then
        echo -e "🎯 AI Tip: ${YELLOW}Low memory - Run quick clean${NC}"
    else
        echo -e "🎯 AI Tip: ${GREEN}System optimal${NC}"
    fi
    echo ""
}

main_menu() {
    while true; do
        show_dashboard
        echo -e "${CYAN}🚀 ENHANCED ACTIONS${NC}"
        echo "=========================================="
        echo "1) 🧹 Quick Clean"
        echo "2) 🚀 Performance Boost" 
        echo "3) 🛡️  Security Scan"
        echo "4) 🤖 AI Optimization"
        echo "5) 🔒 Malware Scanner"
        echo "6) 📊 Health Dashboard"
        echo "7) 🎨 Launch GUI Version"
        echo "8) ❌ Exit"
        echo ""
        
        read -p "Select option [1-8]: " choice
        case $choice in
            1) ./cleanmac.sh --clean ;;
            2) ./cleanmac.sh --performance ;;
            3) ./cleanmac.sh --security ;;
            4) ./ai-optimizer.sh --optimize ;;
            5) ./malware-scanner.sh --scan ;;
            6) ./health-dashboard.sh --report ;;
            7) ./cleanmac-gui.sh ;;
            8) 
                echo -e "${GREEN}👋 Thank you for using CleanMac Pro Enhanced!${NC}"
                exit 0 
                ;;
            *) 
                echo -e "${RED}Invalid option. Please try again.${NC}"
                sleep 1
                ;;
        esac
    done
}

# Start enhanced version
main_menu
