#!/bin/bash
# CleanMac Pro v2.2 - With KILLER Feature

# ... (your existing code) ...

# NEW: System Tune-Up Mode
system_tuneup() {
    echo -e "${YELLOW}🎯 Starting Complete System Tune-Up...${NC}"
    
    # 1. Health Score
    system_score
    
    # 2. Security Scan  
    security_scan
    
    # 3. Deep Clean
    deep_clean
    
    # 4. DNS Optimization
    echo -e "${YELLOW}🌐 Optimizing DNS...${NC}"
    networksetup -setdnsservers Wi-Fi 8.8.8.8 1.1.1.1
    echo -e "${GREEN}✅ DNS optimized to Google & Cloudflare${NC}"
    
    # 5. Final Health Score
    echo -e "${YELLOW}📊 Measuring improvements...${NC}"
    system_score
    
    echo -e "${BLUE}🎉 System Tune-Up Complete!${NC}"
}

# Update menu option
# Add "7) 🎯 Complete Tune-Up" to your menu
