#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../lib/common.sh"
# CleanMac Pro Stable Version - No nested execution issues

PROJECT_DIR="/Users/diba/GitHub/active-projects/CleanMac-Pro"
cd "$PROJECT_DIR"

# Use the fixed version instead of potentially problematic GUI
exec ./cleanmac-fixed.sh
