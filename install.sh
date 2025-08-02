#!/data/data/com.termux/files/usr/bin/bash

# === Colors ===
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Installing RajPro_X_ToolKit...${NC}"

# === Step 1: Update & Install Required Packages ===
pkg update -y && pkg upgrade -y
pkg install -y python git curl golang

# === Optional: Termux Storage Permission ===
if ! [ -d "$HOME/storage" ]; then
  echo -e "${YELLOW}Granting Termux storage permission...${NC}"
  termux-setup-storage
  sleep 2
fi

# === Step 2: Install Python3 Modules ===
pip install --upgrade pip
pip install requests colorama tldextract beautifulsoup4

# === Step 3: Install subfinder (Go tool) ===
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
cp ~/go/bin/subfinder /data/data/com.termux/files/usr/bin/

# === Step 4: Create launcher command (rajpro) ===
LAUNCHER="/data/data/com.termux/files/usr/bin/rajpro"
echo '#!/data/data/com.termux/files/usr/bin/bash' > $LAUNCHER
echo 'curl -sL https://github.com/bughunter11/raj_termux_setup/raw/main/raj_pro_toolkit_v6.3.py | python -' >> $LAUNCHER
chmod +x $LAUNCHER

# === Final Success Message ===
echo -e "${GREEN}✔ RAJ_PRO_TOOLKIT installed successfully!${NC}"
echo -e "👉 Type ${YELLOW}rajpro${NC} to launch the tool"