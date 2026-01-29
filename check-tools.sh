#!/bin/bash
echo "🔍 CleanMac Pro Tool Diagnostics"
echo "================================"

# Check main tools
tools=("cleanmac-smart-cache" "cleanmac-analyze" "cleanmac-large-files" 
       "cleanmac-docker-clean" "cleanmac-security-scan")

for tool in "${tools[@]}"; do
    if [[ -f "./$tool" ]]; then
        echo "✅ $tool: Found ($(wc -l < "./$tool") lines)"
    else
        echo "❌ $tool: MISSING"
    fi
done

# Check scripts
echo -e "\n📁 scripts/ directory:"
if [[ -d "./scripts" ]]; then
    ls -la ./scripts/*.sh 2>/dev/null | awk '{print "  " $9}'
else
    echo "  scripts/ directory not found"
fi
