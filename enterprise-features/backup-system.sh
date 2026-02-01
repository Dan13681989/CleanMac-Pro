#!/bin/bash
echo "💾 CLEANMAC BACKUP SYSTEM"
echo "========================"

case $1 in
    "create")
        echo "📦 Creating system backup..."
        BACKUP_FILE="cleanmac-backup-$(date +%Y%m%d-%H%M%S).tar.gz"
        tar -czf ~/$BACKUP_FILE ~/CleanMac-Pro 2>/dev/null
        echo "✅ Backup created: ~/$BACKUP_FILE"
        ;;
    "restore")
        echo "🔄 Restoring from backup..."
        LATEST_BACKUP=$(ls -t ~/cleanmac-backup-*.tar.gz 2>/dev/null | head -1)
        if [ -n "$LATEST_BACKUP" ]; then
            tar -xzf "$LATEST_BACKUP" -C ~/
            echo "✅ System restored from: $LATEST_BACKUP"
        else
            echo "❌ No backup files found"
        fi
        ;;
    "list")
        echo "📋 Available backups:"
        ls -l ~/cleanmac-backup-*.tar.gz 2>/dev/null || echo "No backups found"
        ;;
    *)
        echo "Usage: $0 {create|restore|list}"
        echo "  create  - Create new backup"
        echo "  restore - Restore latest backup" 
        echo "  list    - List available backups"
        ;;
esac
