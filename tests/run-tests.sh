#!/bin/bash
echo "🧪 CleanMac Pro Test Suite"
echo "========================"

TEST_LOG="$HOME/.cleanmac/logs/test.log"

run_test() {
    local test_name=$1
    local command=$2
    
    echo "Testing: $test_name..."
    if eval "$command"; then
        echo "✅ PASS: $test_name" | tee -a "$TEST_LOG"
        return 0
    else
        echo "❌ FAIL: $test_name" | tee -a "$TEST_LOG"
        return 1
    fi
}

# Test dashboard
run_test "Dashboard Execution" "~/CleanMac-Pro/enterprise-features/cleanmac-enterprise-dashboard.sh"

# Test analytics
run_test "Analytics Execution" "~/CleanMac-Pro/enterprise-features/cleanmac-analytics.sh"

# Test control panel with exit option
run_test "Control Panel" "echo '7' | ~/CleanMac-Pro/enterprise-features/cleanmac-enterprise-control.sh"

# Test remote monitoring generation
run_test "Status Generation" "~/.cleanmac/remote/generate-status.sh"

echo ""
echo "📊 Test results saved to: $TEST_LOG"
