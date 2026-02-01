#!/bin/bash
echo "🌐 STARTING CLEANMAC WEB DASHBOARD"
echo "================================="
echo "Starting web server on http://localhost:8080"

# Create status endpoint
while true; do
    {
        echo "HTTP/1.1 200 OK"
        echo "Content-Type: application/json"
        echo ""
        cat status.json
    } | nc -l 8080
    
    # Update status.json with fresh data
    ./enterprise-features/generate-status.sh
done
