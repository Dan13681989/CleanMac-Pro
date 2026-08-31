#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../lib/common.sh"

parse_common_args "$@"

echo "=== Starting Weekly Cleanup ==="

# Clean Downloads older than 30 days (move to trash)
while IFS= read -r file; do
    move_to_trash "$file"
done < <(find ~/Downloads -type f -mtime +30 -print 2>/dev/null)

# Clean .tmp files on Desktop
while IFS= read -r file; do
    move_to_trash "$file"
done < <(find ~/Desktop -name "*.tmp" -print 2>/dev/null)

# Clean .DS_Store files (move to trash)
while IFS= read -r file; do
    move_to_trash "$file"
done < <(find ~ -name ".DS_Store" -print 2>/dev/null)

echo "Cleaned temporary files"
du -sh ~/Documents ~/Development ~/Media 2>/dev/null || echo "Some folders may not exist."
echo "=== Cleanup Complete ==="
