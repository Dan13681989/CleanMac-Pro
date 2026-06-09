#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

clear
echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║    🚀 CleanMac Pro Main Menu           ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

while true; do
    echo -e "${YELLOW}Please select an option:${NC}"
    echo "1. 📅 Schedule Management"
    echo "2. 🧹 Run Cleaning"
    echo "3. 💾 Backup Management"
    echo "4. 📊 View Logs"
    echo "5. 🛠️  System Tools"
    echo "6. ℹ️  System Info"
    echo "0. Exit"
    echo ""
    read -p "Enter choice (0-6): " choice
    
    case $choice in
        1)
            echo ""
            ./scripts/manage_schedule.sh status
            echo ""
            echo "Schedule Options:"
            echo "a) Enable schedule"
            echo "b) Disable schedule"
            echo "c) Run schedule now"
            echo "d) Back to main menu"
            read -p "Select: " sch_choice
            case $sch_choice in
                a) ./scripts/manage_schedule.sh enable ;;
                b) ./scripts/manage_schedule.sh disable ;;
                c) ./scripts/manage_schedule.sh run quick ;;
                d) continue ;;
            esac
            ;;
        2)
            echo ""
            echo "🧹 Cleaning Options:"
            echo "1) Quick Clean (Browser caches)"
            echo "2) Deep Clean (System caches)"
            echo "3) Network Optimize"
            echo "0) Back"
            read -p "Select: " clean_choice
            case $clean_choice in
                1) ./scripts/manage_schedule.sh run quick ;;
                2) ./scripts/manage_schedule.sh run deep ;;
                3) ./scripts/manage_schedule.sh run network ;;
                0) continue ;;
            esac
            ;;
        3)
            echo ""
            echo "💾 Backup Options:"
            echo "1) Create backup"
            echo "2) List backups"
            echo "3) Clean old backups"
            echo "4) Backup info"
            echo "0) Back"
            read -p "Select: " backup_choice
            case $backup_choice in
                1) ./scripts/backup_system.sh create ;;
                2) ./scripts/backup_system.sh list ;;
                3) ./scripts/backup_system.sh clean ;;
                4) ./scripts/backup_system.sh info ;;
                0) continue ;;
            esac
            ;;
        4)
            echo ""
            echo "📊 Log Options:"
            echo "1) View schedule logs"
            echo "2) View error logs"
            echo "0) Back"
            read -p "Select: " log_choice
            case $log_choice in
                1) tail -20 ~/Library/Logs/CleanMac/scheduled.log ;;
                2) tail -20 ~/Library/Logs/CleanMac/scheduled-error.log 2>/dev/null || echo "No error logs found" ;;
                0) continue ;;
            esac
            ;;
        5)
            echo ""
            echo "🛠️  System Tools:"
            echo "1) Run system cleanup"
            echo "2) Network speed test"
            echo "3) Network monitor"
            echo "0) Back"
            read -p "Select: " tool_choice
            case $tool_choice in
                1) ./scripts/system_cleanup.sh ;;
                2) ./scripts/speed_test.sh ;;
                3) ./scripts/network_monitor.sh ;;
                0) continue ;;
            esac
            ;;
        6)
            echo ""
            echo -e "${GREEN}📊 System Information:${NC}"
            echo "----------------------------------------"
            echo "Hostname: $(hostname)"
            echo "OS: $(sw_vers -productName) $(sw_vers -productVersion)"
            echo "CPU: $(sysctl -n machdep.cpu.brand_string)"
            echo "Memory: $(sysctl -n hw.memsize | awk '{print $1/1024/1024/1024 " GB"}')"
            echo "Disk: $(df -h / | tail -1 | awk '{print $4 " free"}')"
            echo ""
            echo -e "${GREEN}CleanMac Pro Status:${NC}"
            ./scripts/manage_schedule.sh status
            ;;
        0)
            echo "Goodbye! 👋"
            exit 0
            ;;
        *)
            echo "Invalid choice"
            ;;
    esac
    
    echo ""
    echo "Press Enter to continue..."
    read
    clear
    echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║    🚀 CleanMac Pro Main Menu           ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
    echo ""
done
