#!/bin/bash
# Enhanced Error Handling for CleanMac Pro

LOG_FILE="$HOME/.cleanmac/logs/error.log"
mkdir -p "$(dirname "$LOG_FILE")"

log_error() {
    echo "[ERROR] $(date): $1" >> "$LOG_FILE"
    echo "❌ Error: $1"
}

check_dependencies() {
    local missing=()
    
    # Check required commands
    for cmd in top memory_pressure df pmset; do
        if ! command -v "$cmd" &> /dev/null; then
            missing+=("$cmd")
        fi
    done
    
    if [ ${#missing[@]} -gt 0 ]; then
        log_error "Missing dependencies: ${missing[*]}"
        return 1
    fi
    return 0
}

validate_metrics() {
    local cpu=$1 memory=$2 disk=$3
    
    # Validate numeric ranges
    if ! [[ "$cpu" =~ ^[0-9.]+$ ]] || [ "$cpu" -lt 0 ] || [ "$cpu" -gt 100 ]; then
        log_error "Invalid CPU value: $cpu"
        return 1
    fi
    
    if ! [[ "$memory" =~ ^[0-9.]+$ ]] || [ "$memory" -lt 0 ] || [ "$memory" -gt 100 ]; then
        log_error "Invalid memory value: $memory"
        return 1
    fi
    
    return 0
}
