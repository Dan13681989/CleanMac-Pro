#!/bin/bash
echo "========================================="
echo "     macOS System Cleanup Tool          "
echo "========================================="

echo ""
echo "1. Clearing system caches..."
rm -rf ~/Library/Caches/*
echo "✓ Caches cleared"

echo ""
echo "2. Cleaning downloads folder..."
cd ~/Downloads
find . -name "*.dmg" -delete 2>/dev/null
find . -name "*.zip" -delete 2>/dev/null
find . -name "*.pkg" -delete 2>/dev/null
echo "✓ Downloads cleaned"

echo ""
echo "3. Emptying trash..."
rm -rf ~/.Trash/*
echo "✓ Trash emptied"

echo ""
echo "4. Clearing npm cache..."
npm cache clean --force 2>/dev/null || echo "npm not found"
echo "✓ npm cache cleared"

echo ""
echo "5. Clearing Docker (if installed)..."
docker system prune -a --volumes -f 2>/dev/null || echo "Docker not found"
echo "✓ Docker cleaned"

echo ""
echo "========================================="
echo "✅ System cleanup complete!"
echo "========================================="
echo ""
echo "Freed space can be checked with:"
echo "- df -h"
echo "- du -sh ~/* | sort -rh | head -10"
