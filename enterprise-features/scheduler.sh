#!/bin/bash
echo "⏰ CLEANMAC SCHEDULER"
echo "==================="
echo "Current jobs:"
crontab -l 2>/dev/null | grep -i cleanmac || echo "No scheduled jobs"
echo "Use: crontab -e to schedule cleanups"
