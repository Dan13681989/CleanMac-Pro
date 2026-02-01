#!/bin/bash
echo "Testing CleanMac-Pro Optimization Tools..."
echo ""
echo "1. Network Optimizer:"
sudo ./scripts/network_optimizer.sh
echo ""
echo "2. System Cleanup:"
./scripts/system_cleanup.sh
echo ""
echo "3. Network Monitor:"
./scripts/network_monitor.sh
echo ""
echo "✅ All tests completed!"
