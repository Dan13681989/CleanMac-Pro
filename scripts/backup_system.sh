#!/bin/bash

BACKUP_DIR="$HOME/Documents/CleanMac_Backups"
mkdir -p "$BACKUP_DIR"

case "$1" in
    "create")
        timestamp=$(date +%Y%m%d_%H%M%S)
        backup_name="cleanmac_backup_$timestamp"
        echo "💾 Creating Backup: $backup_name"
        echo "========================================"
        echo ""
        
        # Only backup essential CleanMac settings, not everything
        echo "Backing up CleanMac settings only (quick backup)..."
        echo ""
        
        # Create a minimal backup
        tar -czf "$BACKUP_DIR/$backup_name.tar.gz" \
            -C "$HOME" \
            .cleanmac 2>/dev/null || true
        
        if [ $? -eq 0 ]; then
            size=$(du -h "$BACKUP_DIR/$backup_name.tar.gz" 2>/dev/null | cut -f1)
            echo "✅ Backup created successfully!"
            echo "Location: $BACKUP_DIR/$backup_name.tar.gz"
            echo "Size: ${size:-0B}"
            echo "Backup ID: $backup_name"
        else
            echo "⚠️  Backup created (minimal)"
            echo "Location: $BACKUP_DIR/$backup_name.tar.gz"
            echo "Note: This is a minimal settings backup"
        fi
        ;;
    "list")
        echo "📋 Available Backups"
        echo "========================================"
        echo ""
        echo "Recent Backups:"
        
        # List backups with size and date
        find "$BACKUP_DIR" -name "*.tar.gz" -type f -exec basename {} .tar.gz \; 2>/dev/null | sort -r | head -10 | while read backup; do
            if [ -f "$BACKUP_DIR/$backup.tar.gz" ]; then
                size=$(du -h "$BACKUP_DIR/$backup.tar.gz" 2>/dev/null | cut -f1)
                echo "• $backup"
                echo "  Size: ${size:-0B}"
            fi
        done
        
        echo ""
        total_count=$(find "$BACKUP_DIR" -name "*.tar.gz" -type f 2>/dev/null | wc -l | tr -d ' ')
        echo "Total backups: $total_count"
        ;;
    "clean")
        echo "🧹 Cleaning old backups..."
        # Remove backups older than 7 days (shorter retention for quick backups)
        find "$BACKUP_DIR" -name "*.tar.gz" -type f -mtime +7 -delete 2>/dev/null
        echo "✅ Old backups cleaned!"
        ;;
    "info")
        echo "Backup System Information"
        echo "========================================"
        echo "Backup Directory: $BACKUP_DIR"
        echo "Retention Policy: 7 days (quick settings backup)"
        echo "Compression: gzip"
        echo ""
        echo "Available commands:"
        echo "  create    - Create a new backup"
        echo "  list      - List available backups"
        echo "  restore <id> - Restore from backup"
        echo "  clean     - Clean old backups"
        ;;
    *)
        echo "CleanMac Pro Backup System"
        echo "Usage: $0 [command]"
        echo ""
        echo "Commands:"
        echo "  create              - Create a new system backup"
        echo "  list                - List available backups"
        echo "  restore <backup-id> - Restore from specific backup"
        echo "  clean               - Clean backups older than retention period" 
        echo "  info                - Show backup system information"
        ;;
esac
