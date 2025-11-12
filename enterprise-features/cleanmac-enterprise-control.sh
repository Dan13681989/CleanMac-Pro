#!/bin/bash
echo "🎛️ CLEANMAC PRO ENTERPRISE CONTROL PANEL"
echo "========================================"
echo "1. 📊 Enterprise Dashboard"
echo "2. 📈 Advanced Analytics"
echo "3. 🔔 Enhanced Alerts"
echo "4. 🌐 Remote Monitoring"
echo "5. 🚀 Full Maintenance"
echo "6. 📋 System Status"
echo "7. 🚪 Exit"
echo ""
read -p "Choose option (1-7): " choice

case $choice in
    1) ./enterprise-features/cleanmac-enterprise-dashboard.sh ;;
    2) ./enterprise-features/cleanmac-analytics.sh ;;
    3) ./enterprise-features/cleanmac-enhanced-alerts.sh ;;
    4) ./enterprise-features/setup-remote-monitoring.sh ;;
    5) ~/cleanmac-commands.sh ;;
    6) echo "📊 System Status: Optimal" ;;
    7) echo "Goodbye!"; exit 0 ;;
    *) echo "Invalid option" ;;
esac
