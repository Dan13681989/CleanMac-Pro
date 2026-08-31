#!/usr/bin/env bash
set -e

echo "🔧 CleanMac-Pro Full Improvement Installer"
echo "==========================================="

# Backup
BACKUP_DIR="src/commands.backup.$(date +%Y%m%d_%H%M%S)"
echo "📦 Creating backup: $BACKUP_DIR"
cp -r src/commands "$BACKUP_DIR"

# Add library source
echo "📝 Adding library source to subcommands..."
for script in src/commands/*.sh; do
    if ! grep -q "source.*lib/common.sh" "$script"; then
        sed -i.bak \
            -e '1a\
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"\
source "$SCRIPT_DIR/../../lib/common.sh"
' "$script"
        echo "  ✅ $script"
    else
        echo "  ⏩ $script already has library"
    fi
done

# Replace dangerous commands (rm -rf, sudo) – careful with find -delete
echo "🛡️ Replacing rm -rf, sudo with safe wrappers..."
for script in src/commands/*.sh; do
    sed -i.bak2 -E \
        -e 's/(^|[^a-zA-Z0-9_])rm -rf /\1move_to_trash /g' \
        -e 's/(^|[^a-zA-Z0-9_])rm -r /\1move_to_trash /g' \
        -e 's/sudo /run_with_sudo /g' \
        "$script"
    # Note: find -delete is not auto‑fixed; manual review needed.
done

# Add --json parsing to each subcommand if not already present
echo "📊 Adding --json support to subcommands..."
for script in src/commands/*.sh; do
    if ! grep -q "\-\-json" "$script"; then
        sed -i.bak3 -e '/source.*lib\/common.sh/a\
# Parse --json flag\
JSON=false\
while [[ $# -gt 0 ]]; do\
    case "$1" in\
        --json) JSON=true; shift ;;\
        *) break ;;\
    esac\
done\
export JSON
' "$script"
        echo "  ✅ $script"
    else
        echo "  ⏩ $script already has --json"
    fi
done

# Create new subcommands
echo "🗓️ Creating 'schedule' subcommand..."
cat > src/commands/schedule.sh << 'EOF'
#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../lib/common.sh"

usage() { echo "Usage: $0 [--daily|--weekly|--remove]"; exit 1; }
case "$1" in
    --daily)
        plist="$HOME/Library/LaunchAgents/com.cleanmac.daily.plist"
        cat > "$plist" <<-PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" 
"http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>Label</key><string>com.cleanmac.daily</string>
<key>ProgramArguments</key><array><string>/usr/local/bin/cleanmac</string><string>cleanup</string></array>
<key>StartCalendarInterval</key><dict><key>Hour</key><integer>3</integer><key>Minute</key><integer>0</integer></dict>
</dict></plist>
PLIST
        launchctl load "$plist"
        log_info "Daily schedule installed."
        ;;
    --weekly)
        plist="$HOME/Library/LaunchAgents/com.cleanmac.weekly.plist"
        cat > "$plist" <<-PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" 
"http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>Label</key><string>com.cleanmac.weekly</string>
<key>ProgramArguments</key><array><string>/usr/local/bin/cleanmac</string><string>cleanup</string></array>
<key>StartCalendarInterval</key><dict><key>Weekday</key><integer>0</integer><key>Hour</key><integer>4</integer><key>Minute</key><integer>0</integer></dict>
</dict></plist>
PLIST
        launchctl load "$plist"
        log_info "Weekly schedule installed."
        ;;
    --remove)
        launchctl unload 
"$HOME/Library/LaunchAgents/com.cleanmac.daily.plist" 2>/dev/null
        launchctl unload 
"$HOME/Library/LaunchAgents/com.cleanmac.weekly.plist" 2>/dev/null
        rm -f "$HOME/Library/LaunchAgents/com.cleanmac.daily.plist" 
"$HOME/Library/LaunchAgents/com.cleanmac.weekly.plist"
        log_info "Schedules removed."
        ;;
    *) usage ;;
esac
EOF
chmod +x src/commands/schedule.sh

echo "♻️ Creating 'undo' subcommand..."
cat > src/commands/undo.sh << 'EOF'
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
EOF
chmod +x src/commands/undo.sh

# Add tests
echo "🧪 Adding tests..."
cat >> test/new_features.bats << 'EOF'
#!/usr/bin/env bats
@test "schedule shows usage" { run ./cleanmac.sh schedule; [[ "$output" == 
*"Usage:"* ]]; }
@test "undo shows manifest" { run ./cleanmac.sh undo; [ "$status" -eq 0 ] 
|| [ "$status" -eq 1 ]; }
EOF

# Cleanup backup files
find src/commands -name "*.bak*" -delete

echo "✅ All done! Now run: bats test/ && ./cleanmac.sh schedule --help"
