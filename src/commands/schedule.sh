#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../lib/common.sh"
# Parse common args
parse_common_args "$@"

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
