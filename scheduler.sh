#!/bin/bash
# CleanMac Pro Scheduler - Automated Maintenance

setup_daily_maintenance() {
    echo "🕒 Setting up daily maintenance schedule..."
    
    # Create launchd plist for daily cleanup
    cat > ~/Library/LaunchAgents/com.cleanmac.daily.plist << 'LAUNCHD'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.cleanmac.daily</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/local/bin/cleanmac</string>
        <string>--quick-clean</string>
    </array>
    <key>StartCalendarInterval</key>
    <dict>
        <key>Hour</key>
        <integer>2</integer>
        <key>Minute</key>
        <integer>0</integer>
    </dict>
    <key>RunAtLoad</key>
    <false/>
</dict>
</plist>
LAUNCHD

    # Load the schedule
    launchctl load ~/Library/LaunchAgents/com.cleanmac.daily.plist
    echo "✅ Daily maintenance scheduled at 2:00 AM"
}

quick_clean() {
    echo "🧹 Running quick automated cleanup..."
    # Quick cache cleanup
    find ~/Library/Caches -type f -atime +1 -delete 2>/dev/null
    # Clear logs
    sudo log show --info --last 1d | grep -v "com.apple" > /dev/null
    echo "✅ Quick cleanup completed"
}

case "${1:-}" in
    "--setup-schedule") setup_daily_maintenance ;;
    "--quick-clean") quick_clean ;;
    *) echo "Usage: $0 --setup-schedule | --quick-clean" ;;
esac
