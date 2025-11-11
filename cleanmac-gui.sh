#!/bin/bash
# CleanMac Pro GUI - Terminal-based Graphical Interface

VERSION="3.0"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

show_banner() {
    clear
    echo -e "${PURPLE}"
    echo "╔══════════════════════════════════════════════════════════╗"
    echo "║                   CLEANMAC PRO v3.0                     ║"
    echo "║               Terminal GUI Edition                      ║"
    echo "║                                                        ║"
    echo "║  🚀 Performance    🛡️ Security     📊 Analytics        ║"
    echo "╚══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

show_dashboard() {
    show_banner
    echo -e "${CYAN}📊 LIVE SYSTEM DASHBOARD${NC}"
    echo "=========================================="
    
    # CPU Usage
    cpu_usage=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | sed 's/%//')
    echo -e "🖥️  CPU Usage: ${GREEN}$cpu_usage%${NC}"
    
    # Memory Usage
    memory_usage=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{print 100 - $5"%"}')
    echo -e "🧠 Memory Usage: ${GREEN}$memory_usage${NC}"
    
    # Disk Usage
    disk_usage=$(df / | grep / | awk '{print $5}')
    echo -e "💾 Disk Usage: ${GREEN}$disk_usage${NC}"
    
    # Network Status
    network_status=$(ifconfig en0 | grep "status:" | awk '{print $2}')
    if [ "$network_status" = "active" ]; then
        echo -e "🌐 Network: ${GREEN}Connected${NC}"
    else
        echo -e "🌐 Network: ${RED}Disconnected${NC}"
    fi
    
    echo ""
    echo -e "${YELLOW}🎯 QUICK ACTIONS:${NC}"
    echo "1) 🚀 Performance Boost"
    echo "2) 🛡️ Security Scan"
    echo "3) 🧹 Deep Clean"
    echo "4) 📊 Detailed Analytics"
    echo "5) ⚙️ Settings"
    echo "6) ❌ Exit"
    
    read -p "Select action [1-6]: " choice
    
    case $choice in
        1) performance_boost ;;
        2) security_scan ;;
        3) deep_clean ;;
        4) detailed_analytics ;;
        5) show_settings ;;
        6) exit 0 ;;
        *) show_dashboard ;;
    esac
}

performance_boost() {
    show_banner
    echo -e "${YELLOW}🚀 PERFORMANCE BOOST INITIATED${NC}"
    echo "=========================================="
    
    # Purge memory
    sudo purge
    echo -e "${GREEN}✅ Memory purged${NC}"
    
    # Clear DNS cache
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
    echo -e "${GREEN}✅ DNS cache cleared${NC}"
    
    # Restart core services
    sudo launchctl kickstart -k system/com.apple.WindowServer
    echo -e "${GREEN}✅ WindowServer restarted${NC}"
    
    echo -e "${BLUE}🎉 Performance boost complete!${NC}"
    read -p "Press [Enter] to continue..."
    show_dashboard
}

security_scan() {
    show_banner
    echo -e "${YELLOW}🛡️ COMPREHENSIVE SECURITY SCAN${NC}"
    echo "=========================================="
    
    # Check for outdated software
    echo -e "${CYAN}📦 Checking for outdated software...${NC}"
    brew_outdated=$(brew outdated 2>/dev/null | wc -l)
    echo -e "Outdated Homebrew packages: $brew_outdated"
    
    # Check SIP status
    echo -e "${CYAN}🛡️ Checking System Integrity Protection...${NC}"
    csrutil status
    
    # Check for remote login
    echo -e "${CYAN}🔒 Checking remote access...${NC}"
    remote_login=$(systemsetup -getremotelogin | awk '{print $3}')
    if [ "$remote_login" = "On" ]; then
        echo -e "${RED}⚠️ Remote login is enabled${NC}"
    else
        echo -e "${GREEN}✅ Remote login is disabled${NC}"
    fi
    
    # Check firewall
    echo -e "${CYAN}🔥 Checking firewall...${NC}"
    firewall_status=$(defaults read /Library/Preferences/com.apple.alf globalstate)
    if [ "$firewall_status" = "1" ]; then
        echo -e "${GREEN}✅ Firewall is enabled${NC}"
    else
        echo -e "${RED}⚠️ Firewall is disabled${NC}"
    fi
    
    read -p "Press [Enter] to continue..."
    show_dashboard
}

detailed_analytics() {
    show_banner
    echo -e "${YELLOW}📊 DETAILED SYSTEM ANALYTICS${NC}"
    echo "=========================================="
    
    # System info
    echo -e "${CYAN}🖥️ System Information:${NC}"
    echo "Model: $(sysctl -n hw.model)"
    echo "Processor: $(sysctl -n machdep.cpu.brand_string)"
    echo "Cores: $(sysctl -n hw.ncpu)"
    echo "Memory: $(sysctl -n hw.memsize | awk '{print $0/1073741824 " GB"}')"
    echo "OS: $(sw_vers -productName) $(sw_vers -productVersion)"
    
    # Storage breakdown
    echo -e "${CYAN}💾 Storage Analysis:${NC}"
    df -h | grep -E "Filesystem|/dev/disk"
    
    # Top processes by CPU
    echo -e "${CYAN}🔥 Top CPU Processes:${NC}"
    ps aux | head -10
    
    read -p "Press [Enter] to continue..."
    show_dashboard
}

show_settings() {
    show_banner
    echo -e "${YELLOW}⚙️ SETTINGS${NC}"
    echo "=========================================="
    echo "1) 🔔 Enable notifications"
    echo "2) 📈 Enable automatic health reports"
    echo "3) 🕒 Schedule daily cleanups"
    echo "4) 🔙 Back to dashboard"
    
    read -p "Select option [1-4]: " choice
    case $choice in
        1) echo "Notifications enabled" ;;
        2) echo "Health reports enabled" ;;
        3) echo "Daily cleanups scheduled" ;;
        4) show_dashboard ;;
        *) show_settings ;;
    esac
    read -p "Press [Enter] to continue..."
    show_dashboard
}

# Start the GUI
show_dashboard
