#!/bin/bash
echo "🎛️ CLEANMAC PRO ENTERPRISE CONTROL PANEL"
echo "========================================"
echo "1. 📊 Enterprise Dashboard"
echo "2. 📈 Advanced Analytics"
echo "3. 🔔 Enhanced Alerts"
echo "4. 🌐 Remote Monitoring"
echo "5. 🚀 Performance Boost"
echo "6. 🧹 Quick Clean"
echo "7. 🛡️ Security Scan"
echo "8. 📋 System Report"
echo "9. 🚪 Exit"
echo ""
read -p "Choose option (1-9): " choice

case $choice in
    1) ./enterprise-features/cleanmac-enterprise-dashboard.sh ;;
    2) ./enterprise-features/cleanmac-analytics.sh ;;
    3) ./enterprise-features/cleanmac-enhanced-alerts.sh ;;
    4) ./enterprise-features/setup-remote-monitoring.sh ;;
    5) 
        echo "🚀 Boosting performance..."
        sudo purge 2>/dev/null
        echo "✅ Performance boosted!"
        ;;
    6)
        echo "🧹 Cleaning system..."
        rm -rf ~/Library/Caches/* 2>/dev/null
        rm -rf ~/.Trash/* 2>/dev/null
        echo "✅ System cleaned!"
        ;;
    7) ./enterprise-features/security-check.sh ;;
    8)
        echo "📊 SYSTEM REPORT"
        echo "================"
        echo "Hostname: $(hostname)"
        echo "OS: $(sw_vers -productName) $(sw_vers -productVersion)"
        echo "Uptime: $(uptime)"
        echo "Disk: $(df -h / | tail -1)"
        ;;
    9) echo "👋 Goodbye!"; exit 0 ;;
    *) echo "❌ Invalid option" ;;
esac
