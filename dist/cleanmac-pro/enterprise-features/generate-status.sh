#!/bin/bash
CPU_USAGE=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | tr -d '%')
MEMORY_FREE=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{print $5}' | tr -d '%')
DISK_USAGE=$(df -h / | tail -1 | awk '{print $5}' | tr -d '%')
BATTERY=$(pmset -g batt | grep -Eo "\d+%" | head -1 | tr -d '%')

cat > status.json << STATUS_EOF
{
    "system": {
        "hostname": "$(hostname)",
        "os": "$(sw_vers -productName) $(sw_vers -productVersion)",
        "uptime": "$(uptime | awk '{print $3}')"
    },
    "metrics": {
        "cpu_usage": $CPU_USAGE,
        "memory_free": $MEMORY_FREE,
        "disk_usage": $DISK_USAGE,
        "battery": $BATTERY
    },
    "health_score": 100,
    "timestamp": "$(date)"
}
STATUS_EOF
echo "✅ Status updated: $(date)"
