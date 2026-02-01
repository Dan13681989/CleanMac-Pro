#!/bin/bash
echo "🧪 Running CleanMac Pro Basic Tests..."
echo ""

# Test 1: Check if commands are available
echo "1. Testing command availability:"
commands=("cleanmac-dashboard" "cleanmac-analyze" "cleanmac-large-files" "cleanmac-smart-cache")

for cmd in "${commands[@]}"; do
    if command -v $cmd &> /dev/null; then
        echo "✅ $cmd is available"
    else
        echo "❌ $cmd is missing"
    fi
done

# Test 2: Test basic functionality
echo ""
echo "2. Testing basic functionality:"
cleanmac-dashboard --help > /dev/null 2>&1 && echo "✅ Dashboard help works"
cleanmac-analyze --help > /dev/null 2>&1 && echo "✅ Analyze help works"

# Test 3: Check installation
echo ""
echo "3. Checking installation:"
if [ -f "/usr/local/bin/cleanmac-dashboard" ]; then
    echo "✅ CleanMac Pro is properly installed"
else
    echo "❌ CleanMac Pro is not installed in /usr/local/bin/"
fi

echo ""
echo "🎉 Basic tests completed!"
