#!/bin/bash
clear

function is_holehe_installed() {
  command -v holehe >/dev/null 2>&1
}

function is_tor_installed() {
  command -v tor >/dev/null 2>&1
}

if is_tor_installed; then
  echo ""
  echo " Tor is installed"
  echo ""
    proxychains_config="/etc/proxychains4.conf"

  # Contenido del nuevo archivo de configuración
  cat > "$proxychains_config" << EOF
    dynamic_chain
    chain_level=connect
    
    # ProxyList
    socks4  127.0.0.1 9050
    socks5  127.0.0.1 9050
EOF

else
  sudo apt install tor
  proxychains_config="/etc/proxychains4.conf"

  # Contenido del nuevo archivo de configuración
  cat > "$proxychains_config" << 
  EOF
    dynamic_chain
    chain_level=connect
    
    # ProxyList
    socks4  127.0.0.1 9050
    socks5  127.0.0.1 9050
  EOF
fi

if [ $(systemctl is-active tor) = "active" ]; then
  echo "Tor está en ejecución."
else
  echo "Tor no está en ejecución."
  sudo systemctl status tor
  proxychains4 ./osintModule.sh
fi

function install_holehe() {
  echo "holehe is not installed. Installing..."
  git clone https://github.com/megadose/holehe.git
  cd holehe/
  python3 setup.py install  
}

function holeheF() {
    clear
    echo ""
    echo " The creator is not responsible for the use given"
    echo "      to the application and its functions."
    echo ""
    read -p "Gmail for Scann: " EmailOption
    clear
    holehe $EmailOption
    echo ""
}
clear
echo ""
echo " The creator is not responsible for the use given"
echo "      to the application and its functions."
echo ""
echo "Select the type of Osint:"

if is_holehe_installed; then
  echo " [01] holehe"
  
else
  echo " [01] Install holehe (automatic)"
  echo " [02] Other tool (coming soon)"
fi

echo ""
read -p "Select an option: " OsintOption

case $OsintOption in
  1 | 01)
    if is_holehe_installed; then
      holeheF
    else
      install_holehe
    fi
    ;;
  2 | 02)
    echo "Other tool functionality coming soon..."
    ;;
  *)
    echo "Invalid option."
    ;;
esac

read -p "Press any key to exit..."
./noxk1.sh