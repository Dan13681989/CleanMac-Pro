# Add to /etc/sysctl.conf
sudo tee -a /etc/sysctl.conf << EOF
# Network optimizations
net.inet.tcp.delayed_ack=0
net.inet.tcp.recvspace=65536
net.inet.tcp.sendspace=65536
net.inet.udp.recvspace=65536
net.inet.tcp.minmss=536
EOF

# Create launch daemon for automatic optimization
sudo tee /Library/LaunchDaemons/com.user.networkoptimizer.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" 
"http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.user.networkoptimizer</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/sbin/sysctl</string>
        <string>-w</string>
        <string>net.inet.tcp.delayed_ack=0</string>
        <string>net.inet.tcp.recvspace=65536</string>
        <string>net.inet.tcp.sendspace=65536</string>
        <string>net.inet.udp.recvspace=65536</string>
        <string>net.inet.tcp.minmss=536</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
EOF

sudo launchctl load /Library/LaunchDaemons/com.user.networkoptimizer.plist
