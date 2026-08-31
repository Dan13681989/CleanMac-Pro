#!/usr/bin/env bash
# Resolve symlinks to get the real script path
if command -v realpath &>/dev/null; then
    SCRIPT_PATH="$(realpath "$0")"
elif command -v readlink &>/dev/null; then
    SCRIPT_PATH="$(readlink -f "$0" 2>/dev/null || echo "$0")"
else
    SCRIPT_PATH="$0"
fi
SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"
COMMANDS_DIR="$SCRIPT_DIR/src/commands"

# Source shared library
source "$SCRIPT_DIR/lib/common.sh"

# Parse global options (--json and --dry-run)
JSON="false"
DRY_RUN="false"
while [[ $# -gt 0 ]]; do
    case "$1" in
        --json) JSON="true"; shift ;;
        --dry-run) DRY_RUN="true"; shift ;;
        *) break ;;
    esac
done
export JSON
export DRY_RUN


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
# Build argument list with global options
ARGS=()
[[ "$JSON" == "true" ]] && ARGS+=("--json")
[[ "$DRY_RUN" == "true" ]] && ARGS+=("--dry-run")
ARGS+=("$@")

SCRIPT_PATH="$COMMANDS_DIR/${SUBCOMMAND}.sh"
if [[ ! -f "$SCRIPT_PATH" ]]; then
    log_error "Unknown subcommand: '$SUBCOMMAND'"
    exit 1
fi
chmod +x "$SCRIPT_PATH" 2>/dev/null
exec "$SCRIPT_PATH" "${ARGS[@]}"
