#!/bin/bash

# Create a temporary script with the updated menu logic
cat > /tmp/new_main_menu.sh << 'FUNCTION_EOF'
main_menu() {
    while true; do
        show_header
        system_dashboard
        
        echo -e "\n\${GREEN}\${BOLD}🚀 MAIN MENU\${NC}"
        echo "------------------------------------------"
        
        # Dynamic menu counter
        counter=1
        
        # 1. Quick Clean
        if [[ -f "./cleanmac-smart-cache" ]] || [[ -f "./scripts/system_cleanup.sh" ]]; then
            echo "\${counter}) Quick Clean (Safe cache cleaning)"
            quick_option=\$counter
            ((counter++))
        fi
        
        # 2. Analyze Disk Usage  
        if [[ -f "./cleanmac-analyze" ]]; then
            echo "\${counter}) Analyze Disk Usage"
            analyze_option=\$counter
            ((counter++))
        fi
        
        # 3. Find Large Files
        if [[ -f "./cleanmac-large-files" ]]; then
            echo "\${counter}) Find Large Files"
            largefiles_option=\$counter
            ((counter++))
        fi
        
        # 4. Docker Cleanup
        if [[ -f "./cleanmac-docker-clean" ]]; then
            echo "\${counter}) Docker Cleanup"
            docker_option=\$counter
            ((counter++))
        fi
        
        # 5. Security Scan
        if [[ -f "./cleanmac-security-scan" ]]; then
            echo "\${counter}) Security Scan"
            security_option=\$counter
            ((counter++))
        fi
        
        # 6. Network Optimization
        if [[ -f "./scripts/network_optimizer.sh" ]]; then
            echo "\${counter}) Network Optimization"
            network_option=\$counter
            ((counter++))
        fi
        
        # 7. Advanced Tools
        echo "\${counter}) Advanced Tools"
        advanced_option=\$counter
        ((counter++))
        
        # 8. System Monitor
        echo "\${counter}) System Monitor"
        monitor_option=\$counter
        ((counter++))
        
        # 9. Settings
        echo "\${counter}) Settings"
        settings_option=\$counter
        ((counter++))
        
        # 0. Exit
        echo "0) Exit"
        
        echo -ne "\n\${BOLD}Select option: \${NC}"
        read -r choice
        
        # Map choice to function
        case \$choice in
            0) echo -e "\n\${GREEN}👋 Thank you for using CleanMac Pro!\${NC}"; exit 0 ;;
            *)
                # Dynamic function mapping
                if [[ \$choice -eq \$quick_option ]]; then
                    quick_clean_menu
                elif [[ \$choice -eq \$analyze_option ]]; then
                    analyze_disk_menu
                elif [[ \$choice -eq \$largefiles_option ]]; then
                    large_files_menu
                elif [[ \$choice -eq \$docker_option ]]; then
                    docker_cleanup_menu
                elif [[ \$choice -eq \$security_option ]]; then
                    security_scan_menu
                elif [[ \$choice -eq \$network_option ]]; then
                    network_optimize_menu
                elif [[ \$choice -eq \$advanced_option ]]; then
                    advanced_tools_menu
                elif [[ \$choice -eq \$monitor_option ]]; then
                    system_monitor
                elif [[ \$choice -eq \$settings_option ]]; then
                    settings_menu
                else
                    echo -e "\${RED}Invalid selection!\${NC}"
                    sleep 1
                fi
                ;;
        esac
    done
}
FUNCTION_EOF

echo "✅ New menu function created at /tmp/new_main_menu.sh"
echo "You'll need to replace the main_menu function in your cleanmac-interactive script."
