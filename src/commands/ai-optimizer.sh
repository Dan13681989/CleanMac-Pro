#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../lib/common.sh"
# Parse --json flag
JSON=false
while [[ $# -gt 0 ]]; do
    case "$1" in
        --json) JSON=true; shift ;;
        *) break ;;
    esac
done
export JSON
# CleanMac Pro AI Optimizer - Fixed for macOS

ai_performance_scan() {
    echo "🧠 AI PERFORMANCE ANALYSIS"
    echo "=========================================="
    
    echo "🤖 Analyzing system usage patterns..."
    
    # macOS-compatible process listing
    echo "🔍 Identifying resource-heavy processes..."
    top_processes=$(ps -arc -o pid,command,%cpu,%mem -r | head -6)
    echo "Top CPU processes:"
    echo "$top_processes"
    
    echo "💾 Analyzing memory allocation..."
    memory_hogs=$(ps -amc -o pid,command,%cpu,%mem -r | head -6)
    echo "Memory-intensive processes:"
    echo "$memory_hogs"
    
    echo "📊 Checking system activity..."
    echo "System load: $(sysctl -n vm.loadavg)"
    
    # Generate AI recommendations
    echo ""
    echo "🎯 AI OPTIMIZATION RECOMMENDATIONS:"
    
    # Check CPU usage with bc for floating point
    cpu_usage=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | sed 's/%//')
    if command -v bc >/dev/null 2>&1 && [ $(echo "$cpu_usage > 70" | bc -l) -eq 1 ]; then
        echo "⚠️  High CPU usage detected - consider limiting resource-heavy apps"
    fi
    
    # Check memory pressure
    memory_free=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{print $5}' | tr -d '%')
    if [ "$memory_free" -lt 20 ]; then
        echo "⚠️  Low memory - close unused applications"
    fi
    
    echo "✅ AI analysis complete!"
}

smart_optimize() {
    echo "🚀 SMART AI OPTIMIZATION"
    echo "=========================================="
    
    echo "🤖 Analyzing current system state..."
    
    # Get current usage patterns
    cpu_usage=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | sed 's/%//')
    memory_free=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{print $5}' | tr -d '%')
    
    echo "Current CPU: ${cpu_usage}%"
    echo "Free Memory: ${memory_free}%"
    
    # Adaptive optimization strategy using bc for comparison
    if command -v bc >/dev/null 2>&1 && [ $(echo "$cpu_usage > 70" | bc -l) -eq 1 ]; then
        echo "🔴 High CPU detected - aggressive optimization"
        run_with_sudo purge 2>/dev/null
        run_with_sudo dscacheutil -flushcache
        run_with_sudo killall -HUP mDNSResponder
        echo "✅ Aggressive memory and DNS optimization applied"
    elif [ "$memory_free" -lt 25 ]; then
        echo "🟡 Low memory detected - memory-focused optimization"
        run_with_sudo purge 2>/dev/null
        echo "✅ Memory optimization applied"
    else
        echo "🟢 System healthy - standard optimization"
        run_with_sudo dscacheutil -flushcache
        run_with_sudo killall -HUP mDNSResponder
        echo "✅ Standard optimization applied"
    fi
    
    echo "🎉 AI optimization complete!"
}

case "${1:-}" in
    "--analyze") ai_performance_scan ;;
    "--optimize") smart_optimize ;;
    *) 
        echo "AI Optimizer - Usage:"
        echo "  --analyze   : AI performance analysis"
        echo "  --optimize  : Smart AI optimization"
        ;;
esac
