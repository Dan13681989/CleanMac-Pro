#!/bin/bash
echo "================================================"
echo "🚀 CleanMac Pro v3.0.0 + Custom Features"
echo "================================================"
echo ""
echo "Choose interface:"
echo "1) New Interactive Dashboard (Official v3.0.0 - Fixed)"
echo "2) Custom Menu with Scheduling & Backup"
echo "3) Direct Schedule Management"
echo "4) Quick Backup"
echo "5) View Logs"
echo "0) Exit"
echo ""
read -p "Select: " choice

case $choice in
    1) ./cleanmac-interactive ;;
    2) ./cleanmac-custom-menu.sh ;;
    3) ./scripts/manage_schedule.sh status ;;
    4) ./scripts/backup_system.sh create ;;
    5) tail -20 ~/Library/Logs/CleanMac/scheduled.log ;;
    0) echo "Goodbye!"; exit 0 ;;
    *) echo "Invalid choice" ;;
esac
