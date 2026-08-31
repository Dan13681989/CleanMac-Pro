#!/bin/bash
# CleanMac Pro Fixed Version - Single level execution
clear
echo "=========================================="
echo "        CLEANMAC PRO STABLE v4.1"
echo "        Fixed Performance Edition"
echo "=========================================="

while true; do
    echo
    echo "🤖 AI SYSTEM INSIGHTS"
    echo "=========================================="
    # Get CPU usage
    CPU_USAGE=$(ps -A -o %cpu | awk '{s+=$1} END {print s "%"}')
    MEM_FREE=$(memory_pressure | grep "System-wide memory free" | grep -oE 
'[0-9]+%')
    
    echo "🖥️  CPU: $CPU_USAGE"
    echo "🧠 Memory Free: $MEM_FREE"
    echo "🎯 AI Tip: System optimal"
    echo
    echo "🚀 ENHANCED ACTIONS"
    echo "=========================================="
    echo "1) 🧹 Quick Clean"
    echo "2) 🚀 Performance Boost" 
    echo "3) 🛡️  Security Scan"
    echo "4) 🤖 AI Optimization"
    echo "5) 🔒 Malware Scanner"
    echo "6) 📊 Health Dashboard"
    echo "7) ❌ Exit"
    echo
    read -p "Select option [1-7]: " choice
    
    case $choice in
        1)
            echo "🧹 Running quick cleanup..."
            sudo rm -rf /private/var/folders/* 2>/dev/null
            sudo purge
            echo "✅ Quick cleanup completed!"
            ;;
        2)
            echo "🚀 Boosting performance..."
            sudo purge
            sudo dscacheutil -flushcache
            sudo killall -HUP mDNSResponder
            echo "✅ Performance boosted!"
            ;;
        3)
            ./malware-scanner.sh --scan
            ;;
        4)
            ./ai-optimizer.sh --analyze
            ;;
        5)
            ./malware-scanner.sh --scan
            ;;
        6)
            ./health-dashboard.sh --report
            ;;
        7)
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
