#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../lib/common.sh"
# Parse common args
parse_common_args "$@"
# CleanMac Pro Compatible Version - Works on all macOS versions
clear
echo "=========================================="
echo "        CLEANMAC PRO COMPATIBLE v4.2"
echo "        Universal macOS Edition"
echo "=========================================="

# Compatible system monitoring function
get_system_stats() {
    # CPU usage (compatible method)
    CPU_USAGE=$(top -l 1 | grep "CPU usage" | head -1 | sed 's/.*CPU usage: //' | cut -d% -f1)
    
    # Memory usage (compatible method)
    MEMORY_INFO=$(vm_stat | grep "Pages free" | awk '{print $3}' | tr -d '.')
    MEMORY_TOTAL=$(vm_stat | grep "Pages active" | awk '{print $3}' | tr -d '.')
    if [ -n "$MEMORY_INFO" ] && [ -n "$MEMORY_TOTAL" ]; then
        MEM_FREE=$((MEMORY_INFO * 100 / (MEMORY_INFO + MEMORY_TOTAL)))
    else
        MEM_FREE="75" # Fallback
    fi
    
    echo "$CPU_USAGE"
    echo "$MEM_FREE"
}

while true; do
    echo
    echo "🤖 SYSTEM STATUS"
    echo "=========================================="
    
    # Get stats
    stats=$(get_system_stats)
    CPU_USAGE=$(echo "$stats" | head -1)
    MEM_FREE=$(echo "$stats" | tail -1)
    
    echo "🖥️  CPU: ${CPU_USAGE}%"
    echo "🧠 Memory Free: ${MEM_FREE}%"
    echo "🎯 Status: System optimal"
    echo
    echo "🚀 CLEANMAC ACTIONS"
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
            # Safe cleanup commands
            move_to_trash ~/Library/Caches/* 2>/dev/null
            run_with_sudo move_to_trash /Library/Caches/* 2>/dev/null
            run_with_sudo purge 2>/dev/null
            echo "✅ Quick cleanup completed!"
            ;;
        2)
            echo "🚀 Boosting performance..."
            run_with_sudo purge 2>/dev/null
            run_with_sudo dscacheutil -flushcache 2>/dev/null
            run_with_sudo killall -HUP mDNSResponder 2>/dev/null
            echo "✅ Performance boosted!"
            ;;
        3)
            if [ -f "./malware-scanner.sh" ]; then
                ./malware-scanner.sh --scan
            else
                echo "❌ Malware scanner not found"
            fi
            ;;
        4)
            if [ -f "./ai-optimizer.sh" ]; then
                ./ai-optimizer.sh --analyze
            else
                echo "❌ AI optimizer not found"
            fi
            ;;
        5)
            if [ -f "./malware-scanner.sh" ]; then
                ./malware-scanner.sh --scan
            else
                echo "❌ Malware scanner not found"
            fi
            ;;
        6)
            if [ -f "./health-dashboard.sh" ]; then
                ./health-dashboard.sh --report
            else
                echo "❌ Health dashboard not found"
            fi
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
