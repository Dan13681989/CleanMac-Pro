#!/bin/bash
echo "🏢 CLEANMAC PRO ENTERPRISE DASHBOARD"
echo "==================================="
echo "Generated: $(date)"
echo "System: $(hostname)"
echo "==================================="

# Get system metrics
CPU_USAGE=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | tr -d '%' | cut -d. -f1)
MEMORY_FREE=$(memory_pressure | grep "System-wide memory free" | grep -oE '[0-9]+' | head -1)
DISK_USAGE=$(df -h / | tail -1 | awk '{print $5}')
BATTERY=$(pmset -g batt | grep -oE '[0-9]+%' | head -1)
UPTIME=$(uptime | awk '{print $3 " " $4}' | sed 's/,//')

echo "📊 ENHANCED METRICS:"
echo "-------------------"
echo "🖥️  CPU Usage:    ${CPU_USAGE}%"
echo "🧠 Memory Free:  ${MEMORY_FREE}%"
echo "💾 Disk Usage:   ${DISK_USAGE}"
echo "🔋 Battery:      ${BATTERY}"
echo "⏱️  Uptime:       ${UPTIME}"
echo ""
echo "🚀 ENTERPRISE COMMANDS:"
echo "----------------------"
echo "cleanmac-enterprise    # Full control panel"
echo "cleanmac-dashboard     # This dashboard"
echo "cleanmac-security-scan # Security scan"
echo "cleanmac-clean-now     # Quick cleanup"
