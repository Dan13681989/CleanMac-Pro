#!/bin/bash
# CleanMac Pro Schedule Manager

PLIST_DAILY="$HOME/Library/LaunchAgents/com.dan13681989.cleanmac.daily.plist"
PLIST_WEEKLY="$HOME/Library/LaunchAgents/com.dan13681989.cleanmac.weekly.plist"
LOG_DIR="$HOME/Library/Logs/CleanMac"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

create_log_dir() {
    mkdir -p "$LOG_DIR"
}

show_status() {
    echo -e "${BLUE}📅 CleanMac Pro Schedule Status${NC}"
    echo "========================================"
    
    # Check daily schedule
    if launchctl list | grep -q "com.dan13681989.cleanmac.daily"; then
        echo -e "Daily Clean (3:00 AM): ${GREEN}ACTIVE ✓${NC}"
    else
        echo -e "Daily Clean (3:00 AM): ${RED}INACTIVE ✗${NC}"
    fi
    
    # Check weekly schedule
    if launchctl list | grep -q "com.dan13681989.cleanmac.weekly"; then
        echo -e "Weekly Deep Clean (Sun 4:00 AM): ${GREEN}ACTIVE ✓${NC}"
    else
        echo -e "Weekly Deep Clean (Sun 4:00 AM): ${RED}INACTIVE ✗${NC}"
    fi
    
    # Show next runs
    echo -e "\n${YELLOW}Next Scheduled Runs:${NC}"
    if [[ -f "$PLIST_DAILY" ]]; then
        echo "Daily: Tomorrow at 3:00 AM"
    fi
    if [[ -f "$PLIST_WEEKLY" ]]; then
        echo "Weekly: Next Sunday at 4:00 AM"
    fi
    
    # Show log info
    if [[ -f "$LOG_DIR/scheduled.log" ]]; then
        echo -e "\n${YELLOW}Last Log Entry:${NC}"
        tail -3 "$LOG_DIR/scheduled.log"
    fi
}

enable_schedule() {
    create_log_dir
    
    echo -e "${GREEN}Enabling scheduled cleaning...${NC}"
    
    # Load daily schedule
    if [[ -f "$PLIST_DAILY" ]]; then
        launchctl load -w "$PLIST_DAILY" 2>/dev/null
        echo -e "  Daily schedule: ${GREEN}Loaded${NC}"
    fi
    
    # Load weekly schedule
    if [[ -f "$PLIST_WEEKLY" ]]; then
        launchctl load -w "$PLIST_WEEKLY" 2>/dev/null
        echo -e "  Weekly schedule: ${GREEN}Loaded${NC}"
    fi
    
    show_status
}

disable_schedule() {
    echo -e "${YELLOW}Disabling scheduled cleaning...${NC}"
    
    # Unload daily schedule
    launchctl unload "$PLIST_DAILY" 2>/dev/null && \
        echo -e "  Daily schedule: ${RED}Unloaded${NC}"
    
    # Unload weekly schedule
    launchctl unload "$PLIST_WEEKLY" 2>/dev/null && \
        echo -e "  Weekly schedule: ${RED}Unloaded${NC}"
    
    show_status
}

run_now() {
    echo -e "${BLUE}Running scheduled clean now...${NC}"
    ./scripts/scheduled_clean.sh "$1"
}

case "$1" in
    "enable"|"start")
        enable_schedule
        ;;
    "disable"|"stop")
        disable_schedule
        ;;
    "status")
        show_status
        ;;
    "run"|"now")
        run_now "${2:-quick}"
        ;;
    "logs")
        if [[ -f "$LOG_DIR/scheduled.log" ]]; then
            echo -e "${YELLOW}Showing last 20 log entries:${NC}"
            tail -20 "$LOG_DIR/scheduled.log"
        else
            echo "No logs found."
        fi
        ;;
    *)
        echo "Usage: $0 [command]"
        echo "Commands:"
        echo "  enable/start   - Enable scheduled cleaning"
        echo "  disable/stop   - Disable scheduled cleaning"
        echo "  status         - Show schedule status"
        echo "  run [type]     - Run scheduled clean now (quick|deep|network)"
        echo "  logs           - Show recent logs"
        ;;
esac
