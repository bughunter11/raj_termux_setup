#!/data/data/com.termux/files/usr/bin/bash

# === Colors ===
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Installing RajPro_X_ToolKit (GitHub-streamed)...${NC}"

# === Step 1: Install Required Packages ===
pkg update -y && pkg upgrade -y
pkg install -y python git curl golang

# === Step 2: Install Python Modules ===
pip install --upgrade pip
pip install requests colorama tldextract beautifulsoup4

# === Step 3: Install subfinder via Go ===
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
cp ~/go/bin/subfinder /data/data/com.termux/files/usr/bin/

# === Step 4: Create rajpro launcher that streams script directly ===
LAUNCHER="/data/data/com.termux/files/usr/bin/rajpro"
echo '#!/data/data/com.termux/files/usr/bin/bash' > $LAUNCHER
echo 'curl -sL https://raw.githubusercontent.com/bughunter11/raj_termux_setup/main/raj_pro_toolkit_v6.3.py | python3 -' >> $LAUNCHER
chmod +x $LAUNCHER

echo -e "${GREEN}✔ Installed Successfully!${NC}"
echo -e "👉 Type ${YELLOW}rajpro${NC} to run the tool directly from GitHub (no local file used)"