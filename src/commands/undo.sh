#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../lib/common.sh"

TRASH_DIR="$HOME/.cleanmac/trash"
MANIFEST="$TRASH_DIR/manifest.log"

if [[ ! -f "$MANIFEST" ]]; then
    log_error "No trash manifest found."
    exit 1
fi

# Non‑interactive mode for testing (--auto)
if [[ "$1" == "--auto" || "$1" == "-a" ]]; then
    echo "Restoring all files from trash..."
    while IFS= read -r line; do
        # Extract source and destination using sed
        # Format: "2026-08-31 14:13:03 Moved /src -> /dest"
        src=$(echo "$line" | sed -E 's/^[0-9-]+ [0-9:]+ Moved (.*) -> (.*)$/\1/')
        dest=$(echo "$line" | sed -E 's/^[0-9-]+ [0-9:]+ Moved (.*) -> (.*)$/\2/')
        if [[ -e "$dest" ]]; then
            mv "$dest" "$src" 2>/dev/null && log_info "Restored $src"
        else
            log_warn "Destination file not found: $dest"
        fi
    done < "$MANIFEST"
    exit 0
fi

# Interactive mode
echo "Recent trash entries:"
tail -10 "$MANIFEST" | nl
read -p "Enter line number to restore (or 'all'): " choice

if [[ "$choice" == "all" ]]; then
    while IFS= read -r line; do
        src=$(echo "$line" | sed -E 's/^[0-9-]+ [0-9:]+ Moved (.*) -> (.*)$/\1/')
        dest=$(echo "$line" | sed -E 's/^[0-9-]+ [0-9:]+ Moved (.*) -> (.*)$/\2/')
        if [[ -e "$dest" ]]; then
            mv "$dest" "$src" 2>/dev/null && log_info "Restored $src"
        else
            log_warn "Destination file not found: $dest"
        fi
    done < "$MANIFEST"
    log_info "All restored."
else
    line=$(sed -n "${choice}p" "$MANIFEST")
    if [[ -z "$line" ]]; then
        log_error "Invalid line number."
        exit 1
    fi
    src=$(echo "$line" | sed -E 's/^[0-9-]+ [0-9:]+ Moved (.*) -> (.*)$/\1/')
    dest=$(echo "$line" | sed -E 's/^[0-9-]+ [0-9:]+ Moved (.*) -> (.*)$/\2/')
    if [[ -e "$dest" ]]; then
        mv "$dest" "$src" 2>/dev/null && log_info "Restored $src"
    else
        log_error "File not found in trash."
    fi
fi
