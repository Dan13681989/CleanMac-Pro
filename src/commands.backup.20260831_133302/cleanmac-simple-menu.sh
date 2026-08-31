#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../lib/common.sh"
# CleanMac Pro Simple Menu - ASCII only
clear
echo "============================================================"
echo "               CLEANMAC PRO SIMPLE v4.2"
echo "               Compatible Menu Edition"
echo "============================================================"

while true; do
    echo
    echo "SYSTEM DASHBOARD"
    echo "=========================================="
    echo "CPU:    $(top -l 1 | grep 'CPU usage' | head -1 | sed 's/.*CPU usage: //' | cut -d% -f1)%"
    echo "Memory: Calculating..."
    echo "Disk:   $(df -h / | tail -1 | awk '{print $5}') used"
    echo
    echo "QUICK ACTIONS:"
    echo "1) Performance Boost"
    echo "2) Security Scan"
    echo "3) Deep Clean"
    echo "4) Health Dashboard"
    echo "5) Back to Main Menu"
    echo "6) Exit"
    echo
    read -p "Select action [1-6]: " action
    
    case $action in
        1)
            echo "PERFORMANCE BOOST INITIATED"
            echo "=========================================="
            sudo purge 2>/dev/null
            echo "Memory purged"
            sudo dscacheutil -flushcache 2>/dev/null
            echo "DNS cache cleared"
            ;;
        2)
            if [ -f "./malware-scanner.sh" ]; then
                ./malware-scanner.sh --scan
            else
                echo "Malware scanner not available"
            fi
            ;;
        3)
            echo "RUNNING DEEP CLEAN..."
            echo "=========================================="
            rm -rf ~/Library/Caches/* 2>/dev/null
            sudo rm -rf /Library/Caches/* 2>/dev/null
            echo "Deep cleanup completed!"
            ;;
        4)
            if [ -f "./health-dashboard.sh" ]; then
                ./health-dashboard.sh --report
            else
                echo "Health dashboard not available"
            fi
            ;;
        5)
            exec ./cleanmac-compatible.sh
            ;;
        6)
            echo "Thank you for using CleanMac Pro!"
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
