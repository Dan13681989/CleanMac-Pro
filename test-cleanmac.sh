#!/bin/bash

echo "🧪 Testing CleanMac Pro Installation..."
echo "======================================="

# Test 1: Check all scripts are executable
echo "📋 1. Checking script permissions..."
for script in cleanmac cleanmac-smart-cache cleanmac-docker-clean; do
    if [ -x "$script" ]; then
        echo "   ✅ $script is executable"
    else
        echo "   ❌ $script is NOT executable"
        chmod +x "$script" 2>/dev/null && echo "   🔧 Fixed permissions for $script"
    fi
done

# Test 2: Test config file loading
echo ""
echo "📋 2. Testing config file loading..."
echo 'CLEANMAC_BACKUP_DIR="$HOME/Desktop/cleanmac_test"' > /tmp/test-config.rc
CLEANMAC_CONFIG="/tmp/test-config.rc" ./cleanmac-smart-cache -n 2>&1 | grep -q "Using backup directory" && echo "   ✅ Config file loads correctly" || echo "   ❌ Config file not loading"

# Test 3: Test dry run
echo ""
echo "📋 3. Testing dry run functionality..."
./cleanmac cache -n 2>&1 | grep -q "DRY RUN" && echo "   ✅ Dry run works" || echo "   ❌ Dry run not working"

# Test 4: Test Docker script
echo ""
echo "📋 4. Testing Docker cleanup script..."
./cleanmac docker -n 2>&1 | grep -q "DRY RUN" && echo "   ✅ Docker dry run works" || echo "   ❌ Docker script issue"

# Test 5: Test main CLI
echo ""
echo "📋 5. Testing main CLI..."
./cleanmac --help 2>&1 | grep -q "Available commands" && echo "   ✅ Main CLI works" || echo "   ❌ Main CLI issue"

echo ""
echo "======================================="
echo "✅ Testing completed!"
echo ""
echo "Quick commands:"
echo "  ./cleanmac cache -n      # Test cache cleaning (dry run)"
echo "  ./cleanmac docker -n     # Test Docker cleanup (dry run)"
echo "  ./cleanmac --help        # See all commands"
