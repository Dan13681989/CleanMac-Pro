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
# CleanMac Pro Stable Version - No nested execution issues

PROJECT_DIR="/Users/diba/GitHub/active-projects/CleanMac-Pro"
cd "$PROJECT_DIR"

# Use the fixed version instead of potentially problematic GUI
exec ./cleanmac-fixed.sh
