#!/bin/bash
echo "🏢 CLEANMAC PRO ENTERPRISE DASHBOARD"
echo "==================================="
echo "Generated: \$(date)"
echo "System: \$(hostname)"
echo "==================================="

# Basic metrics
CPU=\$(top -l 1 | grep "CPU usage" | awk '{print \$3}' | tr -d '%' | cut -d. -f1)
MEMORY=\$(memory_pressure | grep "System-wide memory free" | grep -oE '[0-9]+' | head -1)
DISK=\$(df -h / | tail -1 | awk '{print \$5}')
BATTERY=\$(pmset -g batt | grep -oE '[0-9]+%' | head -1)

echo "📊 METRICS:"
echo "🖥️  CPU: \$CPU% | 🧠 Memory: \$MEMORY%"
echo "💾 Disk: \$DISK | 🔋 Battery: \$BATTERY"
echo ""
echo "🚀 QUICK ACTIONS:"
echo "cleanmac-enterprise | cleanmac-dashboard"
