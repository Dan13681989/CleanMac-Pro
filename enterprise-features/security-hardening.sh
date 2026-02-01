#!/bin/bash
echo "🔒 SECURITY HARDENING TOOLKIT"
echo "============================"

echo "1. 🔍 Firewall Status:"
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate

echo ""
echo "2. 📊 System Integrity Protection:"
csrutil status

echo ""
echo "3. 🛡️ Security Assessment:"
echo "   - Gatekeeper: $(spctl --status)"
echo "   - Automatic Updates: $(defaults read /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled)"

echo ""
echo "4. 💡 Security Recommendations:"
echo "   ✅ Enable FileVault for disk encryption"
echo "   ✅ Use strong passwords and Touch ID"
echo "   ✅ Keep system and apps updated"
echo "   ✅ Avoid installing from unidentified developers"
