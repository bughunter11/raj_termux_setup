#!/bin/bash

# === Colors ===
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}🔍 Detecting Environment...${NC}"

# === Detect Termux or VPS ===
if [[ "$PREFIX" == "/data/data/com.termux/files/usr" ]]; then
    echo -e "${GREEN}✅ Termux Detected!${NC}"

    # === Termux Setup ===
    pkg update -y && pkg upgrade -y
    pkg install -y python git curl golang

    pip install --upgrade pip
    pip install requests colorama tldextract beautifulsoup4

    go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
    cp ~/go/bin/subfinder $PREFIX/bin/

    cd ~
    rm -f BugTraceX.py
    curl -LO https://github.com/bughunter11/raj_termux_setup/raw/main/BugTraceX.py
    chmod +x BugTraceX.py

    # Create launcher command
    echo -e "#!/data/data/com.termux/files/usr/bin/bash\ncd \$HOME && python BugTraceX.py" > $PREFIX/bin/bugtracex
    chmod +x $PREFIX/bin/bugtracex

    echo -e "${GREEN}✔ BugTraceX installed successfully in Termux!${NC}"
    echo -e "👉 Type ${YELLOW}bugtracex${NC} to run"

else
    echo -e "${GREEN}✅ VPS/Linux Detected!${NC}"

    # === VPS Setup ===
    apt update -y && apt upgrade -y
    apt install -y python3 python3-pip git curl wget unzip screen

    pip3 install --upgrade pip
    pip3 install requests colorama tldextract beautifulsoup4

    # Install subfinder
    curl -Ls https://github.com/projectdiscovery/subfinder/releases/latest/download/subfinder_amd64.deb -o subfinder.deb
    apt install -y ./subfinder.deb
    rm -f subfinder.deb

    # Setup project directory
    mkdir -p /opt/BugTraceX
    cd /opt/BugTraceX
    rm -f BugTraceX.py
    curl -LO https://github.com/bughunter11/raj_termux_setup/raw/main/BugTraceX.py
    chmod +x BugTraceX.py

    # Create global launcher
    echo '#!/bin/bash' > /usr/local/bin/bugtracex
    echo 'cd /opt/BugTraceX && python3 BugTraceX.py' >> /usr/local/bin/bugtracex
    chmod +x /usr/local/bin/bugtracex

    echo -e "${GREEN}✔ BugTraceX installed successfully on VPS!${NC}"
    echo -e "👉 Type ${YELLOW}bugtracex${NC} to run"
fi