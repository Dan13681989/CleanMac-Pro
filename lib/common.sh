#!/usr/bin/env bash
# ============================================================
# CleanMac-Pro Shared Library
# ============================================================

# Colors
if [ -t 1 ]; then
    GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; BLUE='\033[0;34m'; NC='\033[0m'
else
    GREEN=''; YELLOW=''; RED=''; BLUE=''; NC=''
fi

# Logging
log_info() { echo -e "${GREEN}[INFO]${NC} $*"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $*" >&2; }
log_error() { echo -e "${RED}[ERROR]${NC} $*" >&2; }
log_debug() { [[ "${DEBUG}" == "true" ]] && echo -e "${BLUE}[DEBUG]${NC} $*" >&2; }

# Config
load_config() {
    local config_file="${HOME}/.cleanmac/config"
    [[ -f "$config_file" ]] && source "$config_file"
}

# Dry-run & safety
DRY_RUN="${DRY_RUN:-false}"

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
        echo "$(date +"%Y-%m-%d %H:%M:%S") Moved $file -> $dest" >> "${trash_dir}/manifest.log"
        log_info "Moved '$file' to trash."
    else
        log_warn "File '$file' does not exist, skipping."
    fi
}

run_with_sudo() {
    if [[ "$DRY_RUN" == "true" ]]; then
        log_info "[DRY RUN] Would run: sudo $*"
        return 0
    fi
    log_info "This operation requires administrative privileges."
    sudo "$@" || log_error "Command failed: sudo $*"
}

# Dependency check
check_dependency() {
    local cmd="$1"
    local hint="$2"
    if ! command -v "$cmd" &>/dev/null; then
        log_error "Missing: '$cmd'"
        [[ -n "$hint" ]] && log_error "Install with: $hint"
        return 1
    fi
    return 0
}

# JSON output
json_output() {
    local status="$1"
    local message="$2"
    local data="$3"
    if [[ "$JSON" == "true" ]]; then
        echo "{\"status\":\"$status\",\"message\":\"$message\",\"data\":$data}"
    fi
}

# Init
load_config
DEBUG="${DEBUG:-false}"

# ------------------------------
# Common argument parser (--json and --dry-run)
# ------------------------------
parse_common_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --json) JSON=true; shift ;;
            --dry-run) DRY_RUN=true; shift ;;
            *) break ;;
        esac
    done
    export JSON
    export DRY_RUN
}
