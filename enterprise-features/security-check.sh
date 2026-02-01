#!/bin/bash
echo "🛡️  CleanMac Pro Security Audit"
echo "============================="

SECURITY_SCORE=100
ISSUES=()

# Check script permissions
check_permissions() {
    local script=$1
    if [[ ! -x "$script" ]]; then
        ISSUES+=("Script not executable: $script")
        SECURITY_SCORE=$((SECURITY_SCORE - 5))
    fi
    
    # Check for suspicious patterns (exclude this script itself)
    if [[ "$script" != *"security-check.sh" ]] && grep -q "rm -rf /" "$script" 2>/dev/null; then
        ISSUES+=("Dangerous pattern in: $script")
        SECURITY_SCORE=$((SECURITY_SCORE - 20))
    fi
}

# Audit all scripts
for script in enterprise-features/*.sh; do
    if [[ -f "$script" ]]; then
        check_permissions "$script"
    fi
done

# Report results
echo "Security Score: $SECURITY_SCORE/100"
if [ ${#ISSUES[@]} -gt 0 ]; then
    echo "Issues found:"
    printf '  - %s\n' "${ISSUES[@]}"
else
    echo "✅ No security issues found"
fi
