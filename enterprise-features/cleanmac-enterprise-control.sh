#!/bin/bash
echo "🎛️ CLEANMAC PRO ENTERPRISE CONTROL PANEL"
echo "========================================"
echo "1. 📊 Enterprise Dashboard"
echo "2. 📈 Advanced Analytics" 
echo "3. 🔔 Enhanced Alerts"
echo "4. 🌐 Remote Monitoring"
echo "5. 🚀 Full Maintenance"
echo "6. 🚪 Exit"
echo ""
read -p "Choose option (1-6): " choice

case $choice in
    1) ~/CleanMac-Pro/enterprise-features/cleanmac-enterprise-dashboard.sh ;;
    2) echo "📈 Analytics system coming soon..." ;;
    3) echo "🔔 Alert system coming soon..." ;;
    4) echo "🌐 Remote monitoring coming soon..." ;;
    5) ~/cleanmac-commands.sh ;;
    6) echo "Goodbye!"; exit 0 ;;
    *) echo "Invalid option" ;;
esac
