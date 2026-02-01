#!/bin/bash
echo "📈 USAGE ANALYTICS & FEEDBACK"
echo "============================"

# Create anonymous usage data
ANALYTICS_FILE="$HOME/.cleanmac/analytics.json"

mkdir -p "$(dirname "$ANALYTICS_FILE")"

# Record this usage
cat > "$ANALYTICS_FILE" << JSON_EOF
{
    "last_run": "$(date)",
    "version": "2.0.0",
    "system": {
        "model": "$(sysctl -n hw.model)",
        "cores": "$(sysctl -n hw.ncpu)",
        "memory_gb": "$(sysctl -n hw.memsize | awk '{print int(\$1/1024/1024/1024)}')",
        "os_version": "$(sw_vers -productVersion)"
    },
    "features_used": [
        "ai_analytics",
        "backup_system",
        "security_hardening"
    ]
}
JSON_EOF

echo "✅ Anonymous usage data recorded (for improvement purposes only)"
echo ""
echo "💡 This helps us understand how CleanMac Pro is used and improve it."
echo "   No personal data is collected. Location: $ANALYTICS_FILE"
