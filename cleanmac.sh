#!/usr/bin/env bash
# ============================================================
# CleanMac-Pro Main Router
# ============================================================
# Usage: cleanmac [subcommand] [options]
# Subcommands: clean, analyze, network, security, docker, etc.
# ============================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMANDS_DIR="$SCRIPT_DIR/src/commands"

# Source the shared library for logging
source "$SCRIPT_DIR/lib/common.sh"

# Show usage if no arguments
if [[ $# -eq 0 ]]; then
    echo "CleanMac-Pro - macOS maintenance toolkit"
    echo ""
    echo "Usage: $0 <subcommand> [options]"
    echo ""
    echo "Available subcommands:"
    for cmd in "$COMMANDS_DIR"/*.sh; do
        if [[ -x "$cmd" ]]; then
            basename "$cmd" .sh
        fi
    done | sort
    echo ""
    echo "For help on a subcommand, run: $0 <subcommand> --help"
    exit 0
fi

SUBCOMMAND="$1"
shift

# Find the script (exact match for the basename)
SCRIPT_PATH="$COMMANDS_DIR/${SUBCOMMAND}.sh"
if [[ ! -f "$SCRIPT_PATH" ]]; then
    # Try with a dash prefix? e.g., clean -> cleanmac-clean? No, we moved all to exact names.
    # We could also look for a script that starts with the subcommand, but we'll keep it simple.
    log_error "Unknown subcommand: '$SUBCOMMAND'"
    log_info "Run '$0' without arguments to see available commands."
    exit 1
fi

# Make sure it's executable
chmod +x "$SCRIPT_PATH" 2>/dev/null

# Execute the script, passing the remaining arguments
exec "$SCRIPT_PATH" "$@"
