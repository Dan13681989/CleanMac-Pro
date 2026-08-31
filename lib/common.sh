#!/usr/bin/env bash
# ============================================================
# CleanMac-Pro Shared Library
# ============================================================
# This file is sourced by all sub‑commands.
# It provides logging, dry‑run, configuration, and safety functions.
# ============================================================

# ------------------------------
# Color & formatting (if terminal supports)
# ------------------------------
if [ -t 1 ]; then
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    RED='\033[0;31m'
    BLUE='\033[0;34m'
    NC='\033[0m' # No Color
else
    GREEN=''; YELLOW=''; RED=''; BLUE=''; NC=''
fi

# ------------------------------
# Logging functions
# ------------------------------
log_info() {
    echo -e "${GREEN}[INFO]${NC} $*"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $*" >&2
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $*" >&2
}

log_debug() {
    if [[ "${DEBUG}" == "true" ]]; then
        echo -e "${BLUE}[DEBUG]${NC} $*" >&2
    fi
}

# ------------------------------
# Configuration loading
# ------------------------------
load_config() {
    local config_file="${HOME}/.cleanmac/config"
    if [[ -f "$config_file" ]]; then
        # shellcheck source=/dev/null
        source "$config_file"
        log_debug "Loaded config from $config_file"
    else
        log_debug "No config file found at $config_file, using defaults."
    fi
}

# ------------------------------
# Dry‑run / safety wrappers
# ------------------------------
# Global variable: DRY_RUN (true/false) - set via --dry-run flag
DRY_RUN="${DRY_RUN:-false}"

# Safe removal: moves files to trash instead of deleting permanently
move_to_trash() {
    local file="$1"
    local trash_dir="${HOME}/.cleanmac/trash"
    mkdir -p "$trash_dir"
    local dest="${trash_dir}/$(basename "$file").$(date +%s)"
    if [[ "$DRY_RUN" == "true" ]]; then
        log_info "[DRY RUN] Would move '$file' to '$dest'"
        return 0
    fi
    if [[ -e "$file" ]]; then
        mv "$file" "$dest"
        echo "$(date '+%Y-%m-%d %H:%M:%S') Moved $file -> $dest" >> "${trash_dir}/manifest.log"
        log_info "Moved '$file' to trash."
    else
        log_warn "File '$file' does not exist, skipping."
    fi
}

# Safe sudo wrapper – prompts user and runs only if needed
run_with_sudo() {
    if [[ "$DRY_RUN" == "true" ]]; then
        log_info "[DRY RUN] Would run: sudo $*"
        return 0
    fi
    log_info "This operation requires administrative privileges."
    sudo "$@" || log_error "Command failed: sudo $*"
}

# ------------------------------
# Dependency checker
# ------------------------------
check_dependency() {
    local cmd="$1"
    local install_hint="$2"
    if ! command -v "$cmd" &>/dev/null; then
        log_error "Missing required command: '$cmd'"
        if [[ -n "$install_hint" ]]; then
            log_error "Install it with: $install_hint"
        fi
        return 1
    fi
    return 0
}

# ------------------------------
# Initialisation (auto‑run when sourced)
# ------------------------------
load_config
# Set DEBUG from config if not already set
DEBUG="${DEBUG:-false}"
