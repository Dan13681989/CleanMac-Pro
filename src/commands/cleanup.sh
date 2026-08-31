#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../lib/common.sh"
# Parse --json flag
JSON=false
while [[ $# -gt 0 ]]; do
    case "$1" in
        --json) JSON=true; shift ;;
        *) break ;;
    esac
done
export JSON

echo "=== Starting Weekly Cleanup ==="

# Clean Downloads older than 30 days
find ~/Downloads -type f -mtime +30 -print 2>/dev/null | while IFS= read 
-r file; do
    move_to_trash "$file"
done

# Clean .tmp files on Desktop
find ~/Desktop -name "*.tmp" -print 2>/dev/null | while IFS= read -r file; 
do
    move_to_trash "$file"
done

# Clean .DS_Store files
find ~ -name ".DS_Store" -print 2>/dev/null | while IFS= read -r file; do
    move_to_trash "$file"
done

echo "Cleaned temporary files"
du -sh ~/Documents ~/Development ~/Media 2>/dev/null || echo "Some folders 
may not exist."
echo "=== Cleanup Complete ==="
