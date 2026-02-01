#!/bin/bash
echo "📊 CleanMac Pro Performance Benchmark"
echo "==================================="

BENCHMARK_LOG="$HOME/.cleanmac/logs/benchmark.log"

run_benchmark() {
    local test_name=$1
    local command=$2
    
    echo "Running: $test_name..."
    local start_time=$(python -c 'import time; print(int(time.time() * 1000))' 2>/dev/null || date +%s000)
    
    # Run command, suppressing output
    eval "$command" > /dev/null 2>&1
    
    local end_time=$(python -c 'import time; print(int(time.time() * 1000))' 2>/dev/null || date +%s000)
    local duration=$((end_time - start_time))
    
    echo "  ⏱️  Duration: ${duration}ms" | tee -a "$BENCHMARK_LOG"
    echo "$test_name: ${duration}ms" >> "$BENCHMARK_LOG"
}

# Benchmark each component
run_benchmark "Dashboard" "~/CleanMac-Pro/enterprise-features/cleanmac-enterprise-dashboard.sh"
run_benchmark "Analytics" "~/CleanMac-Pro/enterprise-features/cleanmac-analytics.sh"
run_benchmark "Alert System" "~/CleanMac-Pro/enterprise-features/cleanmac-enhanced-alerts.sh"

echo ""
echo "📈 Benchmark results: $BENCHMARK_LOG"
