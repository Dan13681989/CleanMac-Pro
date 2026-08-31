#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../lib/common.sh"
# Safe Simple GUI Version
clear
echo 
"╔══════════════════════════════════════════════════════════╗"
echo "║                   CLEANMAC PRO SAFE v4.1                ║"
echo "║               Stable Terminal Edition                   ║"
echo "║                                                        ║"
echo "║  🚀 Performance    🛡️ Security     📊 Analytics        ║"
echo 
"╚══════════════════════════════════════════════════════════╝"

while true; do
    echo
    echo "📊 LIVE SYSTEM DASHBOARD"
    echo "=========================================="
    
    # Safe system monitoring
    CPU_USAGE=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | tr -d 
'%')
    MEM_USAGE=$(memory_pressure | grep "System-wide memory free" | grep 
-oE '[0-9]+')
    DISK_USAGE=$(df -h / | tail -1 | awk '{print $5}' | tr -d '%')
    
    echo "🖥️  CPU Usage: ${CPU_USAGE}%"
    echo "🧠 Memory Free: ${MEM_USAGE}%"
    echo "💾 Disk Usage: ${DISK_USAGE}%"
    echo "🌐 Network: Checking..."
    echo
    echo "🎯 QUICK ACTIONS:"
    echo "1) 🚀 Performance Boost"
    echo "2) 🛡️ Security Scan" 
    echo "3) 🧹 Deep Clean"
    echo "4) 📊 Health Dashboard"
    echo "5) 🔙 Back to Main Menu"
    echo "6) ❌ Exit"
    
    read -p "Select action [1-6]: " action
    
    case $action in
        1)
            echo "🚀 PERFORMANCE BOOST INITIATED"
            echo "=========================================="
            sudo purge
            echo "✅ Memory purged"
            sudo dscacheutil -flushcache
            echo "✅ DNS cache cleared"
            ;;
        2)
            ./malware-scanner.sh --scan
            ;;
        3)
            echo "🧹 RUNNING DEEP CLEAN..."
            echo "=========================================="
            rm -rf ~/Library/Caches/* 2>/dev/null
            sudo rm -rf /Library/Caches/* 2>/dev/null
            echo "✅ Deep cleanup completed!"
            ;;
        4)
            ./health-dashboard.sh --report
            ;;
        5)
            exec ./cleanmac-fixed.sh
            ;;
        6)
            echo "👋 Thank you for using CleanMac Pro!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
    
    echo
    read -p "Press [Enter] to continue..."
    clear
done
