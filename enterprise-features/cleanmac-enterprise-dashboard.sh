#!/bin/bash
echo "🏢 CLEANMAC PRO ENTERPRISE DASHBOARD"
echo "==================================="
CPU_USAGE=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | tr -d '%' | cut -d. -f1)
MEMORY_FREE=$(memory_pressure | grep "System-wide memory free" | grep -oE '[0-9]+' | head -1)
echo "🖥️  CPU: ${CPU_USAGE}% | 🧠 Memory: ${MEMORY_FREE}%"
