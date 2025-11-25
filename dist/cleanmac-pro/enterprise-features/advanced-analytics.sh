#!/bin/bash
echo "📈 ADVANCED SYSTEM ANALYTICS"
echo "==========================="

# CPU Details
echo "🖥️ CPU INFORMATION:"
sysctl -n machdep.cpu.brand_string
echo "Cores: $(sysctl -n hw.ncpu)"
echo ""

# Memory Details
echo "🧠 MEMORY ANALYSIS:"
vm_stat | grep -E "(Pages free|Pages active|Pages inactive)" | while read line; do
    key=$(echo $line | awk '{print $2}')
    value=$(echo $line | awk '{print $3}' | tr -d '.')
    size=$((value * 4096 / 1024 / 1024))
    echo "$key: ${size}MB"
done
echo ""

# Disk Health
echo "💾 DISK HEALTH:"
diskutil list | grep -E "(disk0|disk1)" | head -5
echo "SMART Status: $(diskutil info disk0 | grep "SMART" | awk -F: '{print $2}' | tr -d ' ' || echo "Not Available")"
echo ""

# Battery Health (if laptop)
echo "🔋 BATTERY ANALYSIS:"
system_profiler SPPowerDataType | grep -E "(Cycle Count|Condition|Maximum Capacity)" | head -3
