#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../lib/common.sh"
echo "🔧 CLEANMAC PRO COMPATIBILITY CHECK"
echo "=========================================="

# Check required commands
echo "📋 Checking required utilities..."
commands=("bc" "top" "memory_pressure" "sysctl" "ps")
for cmd in "${commands[@]}"; do
    if command -v "$cmd" &> /dev/null; then
        echo "✅ $cmd: Available"
    else
        echo "❌ $cmd: Not available"
    fi
done

# Check script permissions
echo ""
echo "🔒 Checking script permissions..."
scripts=("cleanmac.sh" "cleanmac-enhanced.sh" "ai-optimizer.sh" "health-dashboard.sh" "malware-scanner.sh")
for script in "${scripts[@]}"; do
    if [ -x "$script" ]; then
        echo "✅ $script: Executable"
    else
        echo "❌ $script: Not executable"
        chmod +x "$script"
        echo "  → Fixed permissions"
    fi
done

echo ""
echo "🎉 Compatibility check complete!"
