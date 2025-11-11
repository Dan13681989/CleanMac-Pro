#!/bin/bash

# CleanMac - Comprehensive macOS Cleaning Script with SIP Status & Control
# Fully working version - no syntax errors

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Default settings
DRY_RUN=false
INTERACTIVE=false
BACKUP=false

# Function to print usage
usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "CleanMac - Comprehensive macOS Cleaning Script with SIP Status & Control"
    echo ""
    echo "OPTIONS:"
    echo "    -d, --dry-run       Show what would be deleted without actually deleting"
    echo "    -i, --interactive   Prompt before each cleanup operation"
    echo "    -b, --backup        Create backup before cleaning (not implemented yet)"
    echo "    --sip-status        Check SIP status only"
    echo "    --sip-enable        Enable SIP (requires Recovery Mode)"
    echo "    --sip-disable       Disable SIP (requires Recovery Mode)"
    echo "    --sip-help          Show SIP management instructions"
    echo "    -h, --help          Show this help message"
    echo ""
    echo "EXAMPLES:"
    echo "    $0                  # Run normal cleanup with SIP check"
    echo "    $0 --dry-run        # Show what would be cleaned"
    echo "    $0 --sip-status     # Check SIP status only"
    echo "    $0 --sip-help       # Show SIP management instructions"
    echo ""
    echo "⚠️  SIP changes require booting into Recovery Mode!"
}

# Function to show SIP management instructions
sip_help() {
    echo -e "${CYAN}🛡️  SIP Management Instructions${NC}"
    echo -e "=========================================="
    echo -e "${YELLOW}⚠️  Important: SIP changes require Recovery Mode!${NC}"
    echo ""
    echo -e "${GREEN}To Enable SIP:${NC}"
    echo "  1. Shut down your Mac"
    echo "  2. Hold Cmd+R and power on (Intel) OR hold Power button (Apple Silicon)"
    echo "  3. Open Terminal from Utilities menu"
    echo "  4. Run: csrutil enable"
    echo "  5. Reboot"
    echo ""
    echo -e "${GREEN}To Disable SIP:${NC}"
    echo "  1. Shut down your Mac"
    echo "  2. Hold Cmd+R and power on (Intel) OR hold Power button (Apple Silicon)"
    echo "  3. Open Terminal from Utilities menu"
    echo "  4. Run: csrutil disable"
    echo "  5. Reboot"
    echo ""
    echo -e "${GREEN}To Check Current Status:${NC}"
    echo "  csrutil status"
    echo ""
    echo -e "${YELLOW}⚠️  Warning: Disabling SIP reduces security!${NC}"
    echo -e "${BLUE}💡 Only disable SIP if absolutely necessary${NC}"
}

# Function to check System Integrity Protection status
check_sip_status() {
    echo -e "🛡️  Checking System Integrity Protection..."
    
    if [ "$DRY_RUN" = true ]; then
        echo -e "[DRY RUN] Would check SIP status"
        return 0
    fi
    
    local sip_status
    sip_status=$(csrutil status 2>/dev/null)
    
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ Failed to check SIP status${NC}"
        echo -e "${YELLOW}⚠️  This may require sudo privileges or Recovery Mode${NC}"
        return 1
    fi
    
    if echo "$sip_status" | grep -q "enabled"; then
        echo -e "${GREEN}✅ SIP is fully enabled (System is secure)${NC}"
        echo -e "${BLUE}📋 SIP Status Details:${NC}"
        echo "$sip_status"
        return 0
    elif echo "$sip_status" | grep -q "disabled"; then
        echo -e "${RED}⚠️  SIP is disabled (System may be vulnerable)${NC}"
        echo -e "${BLUE}📋 SIP Status Details:${NC}"
        echo "$sip_status"
        echo -e "${YELLOW}🔒 Consider enabling SIP in Recovery Mode for better security${NC}"
        return 0
    else
        echo -e "${YELLOW}⚠️  SIP is in custom configuration${NC}"
        echo -e "${BLUE}📋 Current SIP status:${NC}"
        echo "$sip_status"
        echo -e "${YELLOW}🔒 Run 'csrutil enable' in Recovery Mode for full protection${NC}"
        return 0
    fi
}

# Function to attempt SIP enable
enable_sip() {
    echo -e "${CYAN}🛡️  Attempting to enable SIP...${NC}"
    
    if csrutil enable 2>/dev/null; then
        echo -e "${GREEN}✅ SIP enabled successfully!${NC}"
        echo -e "${YELLOW}🔄 Please restart your computer for changes to take effect${NC}"
    else
        echo -e "${RED}❌ Failed to enable SIP${NC}"
        echo -e "${YELLOW}📝 This usually requires booting into Recovery Mode:${NC}"
        echo ""
        echo -e "1. ${CYAN}Shut down your Mac${NC}"
        echo -e "2. ${CYAN}Hold Cmd+R and power on (Intel Mac)${NC}"
        echo -e "   ${CYAN}OR hold Power button until options appear (Apple Silicon)${NC}"
        echo -e "3. ${CYAN}Open Terminal from Utilities menu${NC}"
        echo -e "4. ${CYAN}Run: csrutil enable${NC}"
        echo -e "5. ${CYAN}Restart your Mac${NC}"
    fi
}

# Function to attempt SIP disable
disable_sip() {
    echo -e "${YELLOW}⚠️  Attempting to disable SIP...${NC}"
    echo -e "${RED}🔓 WARNING: Disabling SIP reduces system security!${NC}"
    
    if [ "$INTERACTIVE" = true ]; then
        read -p "Are you sure you want to disable SIP? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo -e "${GREEN}✅ SIP disable cancelled${NC}"
            return 1
        fi
    fi
    
    echo -e "${YELLOW}⏳ Disabling SIP...${NC}"
    
    if csrutil disable 2>/dev/null; then
        echo -e "${GREEN}✅ SIP disabled successfully!${NC}"
        echo -e "${YELLOW}🔄 Please restart your computer for changes to take effect${NC}"
        echo -e "${RED}🔓 Security Warning: SIP is now disabled. Re-enable when possible.${NC}"
    else
        echo -e "${RED}❌ Failed to disable SIP${NC}"
        echo -e "${YELLOW}📝 This usually requires booting into Recovery Mode:${NC}"
        echo ""
        echo -e "1. ${CYAN}Shut down your Mac${NC}"
        echo -e "2. ${CYAN}Hold Cmd+R and power on (Intel Mac)${NC}"
        echo -e "   ${CYAN}OR hold Power button until options appear (Apple Silicon)${NC}"
        echo -e "3. ${CYAN}Open Terminal from Utilities menu${NC}"
        echo -e "4. ${CYAN}Run: csrutil disable${NC}"
        echo -e "5. ${CYAN}Restart your Mac${NC}"
    fi
}

# Function to get directory size safely
get_dir_size() {
    local dir="$1"
    if [ -d "$dir" ]; then
        du -sh "$dir" 2>/dev/null | cut -f1 || echo "0B"
    else
        echo "0B"
    fi
}

# Function to prompt user in interactive mode
prompt_user() {
    local message="$1"
    if [ "$INTERACTIVE" = true ]; then
        read -p "$message (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            return 0
        else
            return 1
        fi
    else
        return 0
    fi
}

# Function to clean Homebrew
clean_homebrew() {
    echo -e "🍺 Cleaning Homebrew..."
    if [ "$DRY_RUN" = true ]; then
        echo -e "[DRY RUN] Would run: brew cleanup"
        echo -e "[DRY RUN] Would run: brew autoremove"
    else
        if command -v brew &> /dev/null; then
            if prompt_user "Clean Homebrew cache and remove old versions?"; then
                brew cleanup
                brew autoremove
                echo -e "✅ Homebrew cleaned"
            else
                echo -e "⏭️  Skipping Homebrew cleanup"
            fi
        else
            echo -e "⚠️  Homebrew not installed, skipping"
        fi
    fi
}

# Function to clean npm cache
clean_npm() {
    echo -e "📦 Cleaning npm cache..."
    if [ "$DRY_RUN" = true ]; then
        echo -e "[DRY RUN] Would run: npm cache clean --force"
    else
        if command -v npm &> /dev/null; then
            if prompt_user "Clean npm cache?"; then
                npm cache clean --force
                echo -e "✅ npm cache cleaned"
            else
                echo -e "⏭️  Skipping npm cache cleanup"
            fi
        else
            echo -e "⚠️  npm not installed, skipping"
        fi
    fi
}

# Function to clean Docker
clean_docker() {
    echo -e "🐳 Cleaning Docker..."
    if [ "$DRY_RUN" = true ]; then
        echo -e "[DRY RUN] Would run: docker system prune -f"
    else
        if command -v docker &> /dev/null; then
            if prompt_user "Clean Docker system (remove unused containers, images, networks)?"; then
                docker system prune -f
                echo -e "✅ Docker cleaned"
            else
                echo -e "⏭️  Skipping Docker cleanup"
            fi
        else
            echo -e "⚠️  Docker not installed, skipping"
        fi
    fi
}

# Function to clean system caches safely
clean_system_caches() {
    echo -e "💾 Cleaning system caches..."
    
    local user_caches=("$HOME/Library/Caches" "$HOME/Library/Logs")
    
    for cache_dir in "${user_caches[@]}"; do
        if [ -d "$cache_dir" ]; then
            local size=$(get_dir_size "$cache_dir")
            if [ "$DRY_RUN" = true ]; then
                echo -e "[DRY RUN] Would clean: $cache_dir ($size)"
            else
                if prompt_user "Clean $cache_dir ($size)?"; then
                    find "$cache_dir" -type f -delete 2>/dev/null || true
                    echo -e "✅ Cleaned $cache_dir"
                else
                    echo -e "⏭️  Skipping $cache_dir"
                fi
            fi
        fi
    done
}

# Function to clean user caches
clean_user_caches() {
    echo -e "👤 Cleaning user caches..."
    local user_dirs=("$HOME/.npm" "$HOME/.cache" "$HOME/.local/share/Trash")
    
    for dir in "${user_dirs[@]}"; do
        if [ -d "$dir" ]; then
            local size=$(get_dir_size "$dir")
            if [ "$DRY_RUN" = true ]; then
                echo -e "[DRY RUN] Would clean: $dir ($size)"
            else
                if prompt_user "Clean $dir ($size)?"; then
                    rm -rf "$dir"/* 2>/dev/null || true
                    echo -e "✅ Cleaned $dir"
                else
                    echo -e "⏭️  Skipping $dir"
                fi
            fi
        fi
    done
}

# Function to clean Python cache safely
clean_python_cache() {
    echo -e "🐍 Cleaning Python cache..."
    local initial_count=0
    local final_count=0
    
    if [ "$DRY_RUN" = true ]; then
        initial_count=$(find "$HOME" -name "__pycache__" -type d 2>/dev/null | wc -l | tr -d ' ')
        echo -e "[DRY RUN] Would remove __pycache__ directories (currently $initial_count found)"
    else
        if prompt_user "Clean Python cache (remove __pycache__ directories)?"; then
            initial_count=$(find "$HOME" -name "__pycache__" -type d 2>/dev/null | wc -l | tr -d ' ')
            
            echo "Removing Python cache directories..."
            
            find "$HOME/Development" -name "__pycache__" -type d -delete 2>/dev/null || true
            find "$HOME" -path "*/venv/*" -name "__pycache__" -type d -delete 2>/dev/null || true
            find "$HOME" -path "*/.venv/*" -name "__pycache__" -type d -delete 2>/dev/null || true
            
            find "$HOME" -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true
            
            final_count=$(find "$HOME" -name "__pycache__" -type d 2>/dev/null | wc -l | tr -d ' ')
            local removed_count=$((initial_count - final_count))
            
            echo -e "✅ Removed $removed_count Python cache directories ($final_count remaining)"
        else
            echo -e "⏭️  Skipping Python cache cleanup"
        fi
    fi
}

# Function to empty trash safely
empty_trash() {
    echo -e "🗑️  Emptying Trash..."
    if [ "$DRY_RUN" = true ]; then
        echo -e "[DRY RUN] Would empty Trash"
    else
        if prompt_user "Empty Trash?"; then
            rm -rf ~/.Trash/* 2>/dev/null || true
            rm -rf "$HOME/.local/share/Trash/files/*" 2>/dev/null || true
            echo -e "✅ Trash emptied"
        else
            echo -e "⏭️  Skipping Trash emptying"
        fi
    fi
}

# Function to clean Xcode derived data and archives
clean_xcode() {
    echo -e "📱 Cleaning Xcode cache..."
    local xcode_dirs=("$HOME/Library/Developer/Xcode/DerivedData" "$HOME/Library/Developer/Xcode/Archives")
    
    for xcode_dir in "${xcode_dirs[@]}"; do
        if [ -d "$xcode_dir" ]; then
            local size=$(get_dir_size "$xcode_dir")
            if [ "$DRY_RUN" = true ]; then
                echo -e "[DRY RUN] Would clean: $xcode_dir ($size)"
            else
                if prompt_user "Clean Xcode $xcode_dir ($size)?"; then
                    rm -rf "$xcode_dir"/* 2>/dev/null
                    echo -e "✅ Cleaned $xcode_dir"
                else
                    echo -e "⏭️  Skipping Xcode cache"
                fi
            fi
        fi
    done
}

# Main function
main() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -d|--dry-run)
                DRY_RUN=true
                shift
                ;;
            -i|--interactive)
                INTERACTIVE=true
                shift
                ;;
            -b|--backup)
                BACKUP=true
                shift
                ;;
            --sip-status)
                check_sip_status
                exit 0
                ;;
            --sip-enable)
                enable_sip
                exit 0
                ;;
            --sip-disable)
                disable_sip
                exit 0
                ;;
            --sip-help)
                sip_help
                exit 0
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            *)
                echo -e "${RED}Unknown option: $1${NC}"
                usage
                exit 1
                ;;
        esac
    done

    echo -e "🚀 Starting CleanMac with SIP Check..."
    echo -e "=========================================="
    
    check_sip_status
    echo -e "=========================================="
    
    if [ "$DRY_RUN" = true ]; then
        echo -e "⚠️  DRY RUN MODE - No files will be deleted"
        echo -e "=========================================="
    fi

    clean_homebrew
    clean_npm
    clean_docker
    clean_system_caches
    clean_user_caches
    clean_python_cache
    clean_xcode
    empty_trash

    echo -e "=========================================="
    if [ "$DRY_RUN" = true ]; then
        echo -e "${GREEN}✅ CleanMac completed!${NC}"
        echo -e "This was a dry run. Run without --dry-run to actually clean."
    else
        echo -e "${GREEN}✅ CleanMac completed!${NC}"
        echo -e "${BLUE}💡 Tip: Run with --dry-run first to see what will be cleaned${NC}"
    fi
    
    if csrutil status 2>/dev/null | grep -q "disabled"; then
        echo -e "${YELLOW}🔓 Reminder: SIP is currently disabled${NC}"
        echo -e "${BLUE}💡 Consider enabling with: $0 --sip-help${NC}"
    fi
}

main "$@"
