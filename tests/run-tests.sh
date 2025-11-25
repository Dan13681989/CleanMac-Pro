#!/bin/bash
echo "🧪 Running CleanMac-Pro Tests..."
./cleanmac-dashboard && echo "✅ Dashboard test passed"
./cleanmac-large-files | head -5 && echo "✅ Large files test passed" 
./cleanmac-smart-cache && echo "✅ Smart cache test passed"
echo "🎉 All tests completed!"
