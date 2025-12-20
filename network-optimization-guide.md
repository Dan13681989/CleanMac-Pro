# macOS Network & System Optimization Guide

## 📊 Based on comprehensive optimization session (Dec 20, 2025)

### **System Cleanup Commands:**

#### **1. Disk Space Analysis:**
```bash
# Check disk usage
diskutil list
du -sh ~/* | sort -rh | head -20
find ~ -type f -size +100M -exec ls -lh {} \;
