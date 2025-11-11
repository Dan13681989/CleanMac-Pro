#!/bin/bash
# Automated release script for CleanMac Pro

VERSION="2.0"
echo "🚀 Creating release v$VERSION..."

# Update installation stats
mkdir -p ~/.cleanmac
echo "$(date) - v$VERSION installed" >> ~/.cleanmac/install.log

# Create release package
mkdir -p release
cp cleanmac.sh release/cleanmac
cp install.sh release/
cp README.md release/

echo "✅ Release package created in ./release/"
echo "📦 Version: $VERSION"
echo "📊 Total installs: $(wc -l < ~/.cleanmac/install.log 2>/dev/null || echo 0)"
