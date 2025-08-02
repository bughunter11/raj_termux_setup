#!/data/data/com.termux/files/usr/bin/bash

# === Colors ===
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Installing RAJ_PRO_TOOLKIT v6.3...${NC}"

# === Step 1: Update & Install Required Packages ===
pkg update -y && pkg upgrade -y
pkg install -y python golang curl git

# === Step 2: Install Python Modules ===
pip install --upgrade pip
pip install requests colorama tldextract beautifulsoup4

# === Step 3: Install subfinder (Go tool) ===
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
cp ~/go/bin/subfinder /data/data/com.termux/files/usr/bin/

# === Step 4: Download raj_pro_toolkit_v6.3.py ===
cd ~
rm -f raj_pro_toolkit_v6.3.py
curl -LO https://github.com/bughunter11/raj_termux_setup/raw/main/raj_pro_toolkit_v6.3.py
chmod +x raj_pro_toolkit_v6.3.py

# === Step 5: Create 'rajpro' launcher command ===
echo 'python ~/raj_pro_toolkit_v6.3.py' > ~/../usr/bin/rajpro
chmod +x ~/../usr/bin/rajpro

# === Done ===
echo -e "${GREEN}✔ RAJ_PRO_TOOLKIT installed successfully!${NC}"
echo -e "👉 Type ${YELLOW}rajpro${NC} to launch the tool"

# === Auto-launch after install ===
rajpro
