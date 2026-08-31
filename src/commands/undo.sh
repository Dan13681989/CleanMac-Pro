#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../lib/common.sh"

TRASH_DIR="$HOME/.cleanmac/trash"
MANIFEST="$TRASH_DIR/manifest.log"
[[ ! -f "$MANIFEST" ]] && { log_error "No trash manifest found."; exit 1; 
}

echo "Recent trash entries:"
tail -10 "$MANIFEST" | nl
read -p "Enter line number to restore (or 'all'): " choice
if [[ "$choice" == "all" ]]; then
    while IFS= read -r line; do
        dest=$(echo "$line" | awk -F'-> ' '{print $2}')
        [[ -e "$dest" ]] && mv "$dest" "$(echo "$line" | awk -F'Moved ' 
'{print $2}' | awk -F' -> ' '{print $1}')"
    done < "$MANIFEST"
    log_info "All restored."
else
    line=$(sed -n "${choice}p" "$MANIFEST")
    dest=$(echo "$line" | awk -F'-> ' '{print $2}')
    original=$(echo "$line" | awk -F'Moved ' '{print $2}' | awk -F' -> ' 
'{print $1}')
    [[ -e "$dest" ]] && mv "$dest" "$original" && log_info "Restored 
$original" || log_error "Not found in trash."
fi
