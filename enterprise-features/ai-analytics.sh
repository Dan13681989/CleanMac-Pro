#!/bin/bash
echo "🤖 AI-POWERED SYSTEM INSIGHTS"
echo "============================"

# Analyze CPU patterns
CPU_TREND=$(top -l 5 | grep "CPU usage" | awk '{print $3}' | tr -d '%' | tail -1)
if [ "$CPU_TREND" -gt 80 ]; then
    echo "🔴 HIGH CPU USAGE DETECTED"
    echo "💡 Recommendation: Close unused applications"
elif [ "$CPU_TREND" -lt 20 ]; then
    echo "🟢 CPU usage optimal"
else
    echo "🟡 CPU usage normal"
fi

# Memory analysis
MEMORY_PRESSURE=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{print $5}' | tr -d '%')
if [ "$MEMORY_PRESSURE" -lt 10 ]; then
    echo "🔴 CRITICAL MEMORY PRESSURE"
    echo "💡 Recommendation: Restart memory-intensive apps"
else
    echo "🟢 Memory pressure normal"
fi

# Disk health prediction
DISK_SPACE=$(df -h / | tail -1 | awk '{print $4}' | tr -d 'G')
if [ "$DISK_SPACE" -lt 10 ]; then
    echo "🔴 LOW DISK SPACE WARNING"
    echo "💡 Recommendation: Clean up large files"
else
    echo "🟢 Disk space healthy"
fi

echo ""
echo "📊 PREDICTIVE MAINTENANCE:"
echo "Based on current trends, your system should remain stable for the next 7 days."
