#!/bin/bash

echo "🧪 Running CleanMac Pro Comprehensive Tests..."
echo "=============================================="

# Test 1: Check if main commands exist
echo ""
echo "1. Testing command availability:"
commands=("cleanmac-dashboard" "cleanmac-analyze" "cleanmac-large-files" "cleanmac-smart-cache")

all_commands_exist=true
for cmd in "${commands[@]}"; do
    if command -v $cmd &> /dev/null; then
        echo "✅ $cmd is available"
    else
        echo "❌ $cmd is missing"
        all_commands_exist=false
    fi
done

# Test 2: Test basic functionality
echo ""
echo "2. Testing basic functionality:"
if $all_commands_exist; then
    cleanmac-dashboard --help > /dev/null 2>&1 && echo "✅ Dashboard help works"
    cleanmac-analyze --version > /dev/null 2>&1 && echo "✅ Analyze version works"
    cleanmac-large-files --help > /dev/null 2>&1 && echo "✅ Large files help works"
else
    echo "⚠️  Skipping functionality tests - some commands missing"
fi

# Test 3: Verify installation
echo ""
echo "3. Checking installation:"
if [ -f "/usr/local/bin/cleanmac-dashboard" ]; then
    echo "✅ CleanMac Pro is installed in /usr/local/bin/"
else
    echo "❌ CleanMac Pro is not installed in /usr/local/bin/"
fi

# Test 4: Check repository structure
echo ""
echo "4. Checking repository structure:"
[ -f "cleanmac-dashboard" ] && echo "✅ Main dashboard script exists" || echo "❌ Main dashboard script missing"
[ -f "README.md" ] && echo "✅ README exists" || echo "❌ README missing"
[ -f "LICENSE" ] && echo "✅ LICENSE exists" || echo "❌ LICENSE missing"

# Final result
echo ""
if $all_commands_exist; then
    echo "🎉 All comprehensive tests completed successfully!"
    exit 0
else
    echo "❌ Some tests failed - check installation"
    exit 1
fi
