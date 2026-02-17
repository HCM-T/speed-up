#!/bin/bash

# အရောင်သတ်မှတ်ချက်များ
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

clear
echo -e "${MAGENTA}=============================================="
echo -e "🌐  NETWORK & TCP OPTIMIZATION STARTING..."
echo -e "==============================================${NC}"

# ၁။ လက်ရှိ Congestion Control ကို စစ်ဆေးခြင်း
echo -e "\n${YELLOW}[1/3]${NC} Checking current TCP Congestion Control..."
CURRENT_CC=$(sysctl net.ipv4.tcp_congestion_control)
echo -e "${CYAN}  → $CURRENT_CC${NC}"

# ၂။ sysctl.conf ထဲသို့ Configuration များ ထည့်သွင်းခြင်း
echo -e "\n${YELLOW}[2/3]${NC} Applying Network Speed Tweaks..."

sudo tee -a /etc/sysctl.conf <<EOF > /dev/null
# Network Optimization by My Script
net.core.rmem_max=67108864
net.core.wmem_max=67108864
net.ipv4.tcp_rmem=4096 87380 67108864
net.ipv4.tcp_wmem=4096 65536 67108864
net.ipv4.tcp_mtu_probing=1
net.ipv4.tcp_fastopen=3
net.ipv4.tcp_slow_start_after_idle=0
EOF

echo -e "${GREEN}✔ Configuration added to /etc/sysctl.conf${NC}"

# ၃။ Settings များ အသက်ဝင်စေရန် Reload လုပ်ခြင်း
echo -e "\n${YELLOW}[3/3]${NC} Reloading sysctl settings..."
sudo sysctl -p > /dev/null
echo -e "${GREEN}✔ Settings Applied Successfully!${NC}"

echo -e "\n${MAGENTA}=============================================="
echo -e "🚀  NETWORK OPTIMIZATION COMPLETE!"
echo -e "==============================================${NC}\n"
