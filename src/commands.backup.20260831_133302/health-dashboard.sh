#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../lib/common.sh"
# CleanMac Pro Health Dashboard

generate_health_report() {
    echo "📊 SYSTEM HEALTH DASHBOARD"
    echo "=========================================="
    echo "Generated: $(date)"
    echo ""
    
    # System Health Score (1-100)
    health_score=100
    
    # CPU Health (25 points)
    echo "🖥️  CPU HEALTH:"
    cpu_usage=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | tr -d '%')
    cpu_temp=$(sudo powermetrics --samplers smc -n1 2>/dev/null | grep "CPU die temperature" | awk '{print $4}' || echo "N/A")
    echo "  Usage: $cpu_usage%"
    echo "  Temperature: $cpu_temp"
    
    if [ $(echo "$cpu_usage > 80" | bc -l) -eq 1 ]; then
        health_score=$((health_score - 10))
        echo "  ⚠️  High CPU usage"
    fi
    
    # Memory Health (25 points)
    echo ""
    echo "🧠 MEMORY HEALTH:"
    memory_free=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{print $5}' | tr -d '%')
    echo "  Free Memory: $memory_free%"
    
    if [ "$memory_free" -lt 20 ]; then
        health_score=$((health_score - 10))
        echo "  ⚠️  Low memory"
    fi
    
    # Disk Health (25 points)
    echo ""
    echo "💾 DISK HEALTH:"
    disk_usage=$(df / | grep / | awk '{print $5}' | tr -d '%')
    disk_health=$(diskutil verifyVolume / 2>/dev/null | grep -c "OK" || echo "N/A")
    echo "  Usage: $disk_usage%"
    echo "  Status: $disk_health"
    
    if [ "$disk_usage" -gt 85 ]; then
        health_score=$((health_score - 10))
        echo "  ⚠️  High disk usage"
    fi
    
    # Battery Health (25 points)
    echo ""
    echo "🔋 BATTERY HEALTH:"
    if [[ $(pmset -g batt | grep -c "Battery") -gt 0 ]]; then
        battery_percent=$(pmset -g batt | grep -o "[0-9]*%" | tr -d '%')
        cycle_count=$(system_profiler SPPowerDataType 2>/dev/null | grep "Cycle Count" | awk '{print $3}' | head -1)
        echo "  Charge: $battery_percent%"
        echo "  Cycle Count: $cycle_count"
        
        if [ "$battery_percent" -lt 20 ]; then
            health_score=$((health_score - 5))
            echo "  ⚠️  Low battery"
        fi
        
        if [ "$cycle_count" -gt 800 ]; then
            health_score=$((health_score - 5))
            echo "  ⚠️  High cycle count"
        fi
    else
        echo "  No battery detected"
    fi
    
    # Overall Health Score
    echo ""
    echo "🏆 OVERALL SYSTEM HEALTH: $health_score/100"
    
    if [ "$health_score" -ge 90 ]; then
        echo "✅ EXCELLENT - Your system is in great condition!"
    elif [ "$health_score" -ge 70 ]; then
        echo "🟡 GOOD - System is healthy with minor issues"
    elif [ "$health_score" -ge 50 ]; then
        echo "🟠 FAIR - Some attention needed"
    else
        echo "🔴 POOR - Immediate attention required"
    fi
}

trend_analysis() {
    echo "📈 SYSTEM TREND ANALYSIS"
    echo "=========================================="
    
    # Create trend data directory
    mkdir -p ~/.cleanmac/trends
    
    # Save current metrics
    current_time=$(date +%s)
    cpu_usage=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | tr -d '%')
    memory_free=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{print $5}' | tr -d '%')
    
    # Save to trend file
    echo "$current_time,$cpu_usage,$memory_free" >> ~/.cleanmac/trends/performance.csv
    
    # Analyze trends
    echo "📊 Performance trends saved"
    echo "📍 Data location: ~/.cleanmac/trends/"
    echo "📅 Use this data for long-term system analysis"
}

case "${1:-}" in
    "--report") generate_health_report ;;
    "--trends") trend_analysis ;;
    *) 
        echo "Health Dashboard - Usage:"
        echo "  --report : Generate health report"
        echo "  --trends : Track performance trends"
        ;;
esac
