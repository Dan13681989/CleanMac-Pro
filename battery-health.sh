#!/bin/bash
# CleanMac Pro Battery Health Monitor

check_battery_health() {
    echo "🔋 BATTERY HEALTH REPORT"
    echo "=========================================="
    
    # Get battery information
    battery_info=$(system_profiler SPPowerDataType | grep -A 10 "Battery Information")
    
    # Cycle count
    cycle_count=$(echo "$battery_info" | grep "Cycle Count" | awk '{print $3}')
    echo -e "${CYAN}🔄 Cycle Count:${NC} $cycle_count"
    
    # Condition
    condition=$(echo "$battery_info" | grep "Condition" | cut -d: -f2 | sed 's/^ *//')
    echo -e "${CYAN}📊 Condition:${NC} $condition"
    
    # Maximum capacity
    max_capacity=$(echo "$battery_info" | grep "Maximum Capacity" | awk '{print $3}')
    echo -e "${CYAN}📈 Maximum Capacity:${NC} $max_capacity%"
    
    # Charging status
    charging=$(pmset -g batt | grep -o "AC Power\|Battery Power")
    if [ "$charging" = "AC Power" ]; then
        echo -e "${CYAN}⚡ Status:${NC} Charging"
    else
        echo -e "${CYAN}⚡ Status:${NC} On Battery"
    fi
    
    # Battery percentage
    battery_percent=$(pmset -g batt | grep -o "[0-9]*%" | sed 's/%//')
    echo -e "${CYAN}📊 Current Charge:${NC} $battery_percent%"
    
    # Health recommendations
    echo ""
    echo -e "${YELLOW}💡 BATTERY HEALTH TIPS:${NC}"
    if [ "$cycle_count" -gt 1000 ]; then
        echo "⚠️  High cycle count - consider battery replacement"
    fi
    
    if [ "$max_capacity" -lt 80 ]; then
        echo "⚠️  Battery capacity below 80% - consider replacement"
    fi
    
    echo "✅ Keep battery between 20-80% for optimal health"
    echo "✅ Avoid leaving laptop plugged in constantly"
    echo "✅ Use original Apple charger"
}

optimize_battery() {
    echo "⚡ OPTIMIZING BATTERY SETTINGS"
    echo "=========================================="
    
    # Enable power nap
    sudo pmset -a powernap 1
    echo -e "${GREEN}✅ Power nap enabled${NC}"
    
    # Set display sleep time
    sudo pmset -a displaysleep 10
    echo -e "${GREEN}✅ Display sleep set to 10 minutes${NC}"
    
    # Put hard disks to sleep when possible
    sudo pmset -a disksleep 10
    echo -e "${GREEN}✅ Disk sleep enabled${NC}"
    
    # Slightly reduce brightness
    osascript -e 'tell application "System Events" to key code 145'
    echo -e "${GREEN}✅ Brightness reduced${NC}"
    
    echo -e "${BLUE}🎉 Battery optimization complete!${NC}"
}

case "${1:-}" in
    "--check") check_battery_health ;;
    "--optimize") optimize_battery ;;
    *) echo "Usage: $0 --check | --optimize" ;;
esac
