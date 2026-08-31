#!/bin/bash
# CleanMac Pro Battery Health Monitor - Fixed Version

check_battery_health() {
    echo "🔋 BATTERY HEALTH REPORT"
    echo "=========================================="
    
    # Get battery information with better error handling
    battery_info=$(system_profiler SPPowerDataType 2>/dev/null)
    
    # Cycle count with fallback
    cycle_count=$(echo "$battery_info" | grep "Cycle Count" | awk '{print $3}')
    if [ -z "$cycle_count" ]; then
        cycle_count="Unknown"
    fi
    echo "🔄 Cycle Count: $cycle_count"
    
    # Condition with fallback
    condition=$(echo "$battery_info" | grep "Condition" | cut -d: -f2 | sed 's/^ *//')
    if [ -z "$condition" ]; then
        condition="Unknown"
    fi
    echo "📊 Condition: $condition"
    
    # Maximum capacity with fallback
    max_capacity=$(echo "$battery_info" | grep "Maximum Capacity" | awk '{print $3}')
    if [ -z "$max_capacity" ]; then
        max_capacity="Unknown"
    fi
    echo "📈 Maximum Capacity: $max_capacity%"
    
    # Charging status
    charging=$(pmset -g batt | grep -o "AC Power\|Battery Power" | head -1)
    if [ "$charging" = "AC Power" ]; then
        echo "⚡ Status: Charging"
    else
        echo "⚡ Status: On Battery"
    fi
    
    # Battery percentage
    battery_percent=$(pmset -g batt | grep -o "[0-9]*%" | sed 's/%//' | head -1)
    echo "📊 Current Charge: $battery_percent%"
    
    # Health recommendations (only if we have numeric values)
    echo ""
    echo "💡 BATTERY HEALTH TIPS:"
    if [[ "$cycle_count" =~ ^[0-9]+$ ]] && [ "$cycle_count" -gt 1000 ]; then
        echo "⚠️  High cycle count - consider battery replacement"
    fi
    
    if [[ "$max_capacity" =~ ^[0-9]+$ ]] && [ "$max_capacity" -lt 80 ]; then
        echo "⚠️  Battery capacity below 80% - consider replacement"
    fi
    
    echo "✅ Keep battery between 20-80% for optimal health"
    echo "✅ Avoid leaving laptop plugged in constantly"
    echo "✅ Use original Apple charger"
}

optimize_battery() {
    echo "⚡ OPTIMIZING BATTERY SETTINGS"
    echo "=========================================="
    
    sudo pmset -a powernap 1 2>/dev/null && echo "✅ Power nap enabled"
    sudo pmset -a displaysleep 10 2>/dev/null && echo "✅ Display sleep set to 10 minutes"
    sudo pmset -a disksleep 10 2>/dev/null && echo "✅ Disk sleep enabled"
    
    echo "🎉 Battery optimization complete!"
}

case "${1:-}" in
    "--check") check_battery_health ;;
    "--optimize") optimize_battery ;;
    *) 
        echo "Usage: $0 --check | --optimize"
        echo "Example: $0 --check"
        ;;
esac
