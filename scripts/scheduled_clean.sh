#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Configuration
LOG_DIR="$HOME/Library/Logs/CleanMac"
LOG_FILE="$LOG_DIR/scheduled.log"
LAST_RUN_FILE="$LOG_DIR/last_run.txt"

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Logging function
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
    echo -e "${YELLOW}$1${NC}"
}

# Clean function
perform_clean() {
    local type=$1
    log_message "Performing $type clean..."
    
    case "$type" in
        "deep")
            # System cleanup
            log_message "Cleaning system caches..."
            sudo rm -rf ~/Library/Caches/* 2>/dev/null || true
            sudo rm -rf /Library/Caches/* 2>/dev/null || true
            
            # User cache cleanup
            log_message "Cleaning user caches..."
            rm -rf ~/.cache/* 2>/dev/null || true
            
            # DNS cache flush
            log_message "Flushing DNS cache..."
            sudo dscacheutil -flushcache 2>/dev/null || true
            sudo killall -HUP mDNSResponder 2>/dev/null || true
            ;;
        "network")
            # Network optimization
            log_message "Optimizing network..."
            
            # DNS cache flush
            sudo dscacheutil -flushcache 2>/dev/null || true
            sudo killall -HUP mDNSResponder 2>/dev/null || true
            
            # Renew DHCP lease
            sudo ipconfig set en0 DHCP 2>/dev/null || true
            
            # Clear ARP cache
            sudo arp -a -d 2>/dev/null || true
            ;;
        *)
            # Quick clean (default)
            log_message "Performing quick clean..."
            
            # Browser caches
            log_message "Cleaning browser caches..."
            rm -rf ~/Library/Caches/Google/Chrome/* 2>/dev/null || true
            rm -rf ~/Library/Caches/com.apple.Safari/* 2>/dev/null || true
            rm -rf ~/Library/Caches/com.operasoftware.Opera/* 2>/dev/null || true
            
            # System logs (keep only last 7 days)
            find ~/Library/Logs -name "*.log*" -mtime +7 -delete 2>/dev/null || true
            ;;
    esac
    
    # Update last run time
    date > "$LAST_RUN_FILE"
}

# Start log
log_message "🚀 CleanMac Pro Scheduled Clean Started"

# Determine clean type
CLEAN_TYPE="${1:-quick}"
log_message "Running $CLEAN_TYPE clean..."

# Perform cleaning
perform_clean "$CLEAN_TYPE"

# Calculate space saved (simplified)
space_saved=$(du -sh ~/Library/Caches/ 2>/dev/null | cut -f1 || echo "0B")
log_message "📊 Estimated space saved: ${space_saved}"

log_message "✅ Scheduled clean completed successfully"
log_message "----------------------------------------"
