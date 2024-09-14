#!/bin/bash

#noxk1.sh

if [ "$EUID" -ne 0 ]; then
    echo "Este script debe ejecutarse como root. Saliendo..."
    exit 1
fi

clear

Version=0.1.7.6

# Colores ANSI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color (reset)

REQUIRED_FILES=("nmapModule.sh" "msfVModule.sh" "noxk1.sh" "keylogg.sh" "update.sh" "Keylogg/WindowsKey.cpp" "osintModule.sh")

check_for_updates() {
    latest_version=$(curl -s -L https://raw.githubusercontent.com/Cesargg55/Noxk1/main/version.txt)
    if [ "$latest_version" != "$Version" ]; then
        echo -e "${YELLOW}Nueva versión disponible: $latest_version${NC}"
        read -p "Deseas actualizar? [s/n]: " update_choice
        if [ "$update_choice" == "s" ]; then
        ./update.sh
        wget -O update.sh https://raw.githubusercontent.com/Cesargg55/Noxk1/main/update.sh
        fi
    fi
}

check_files_and_permissions() {
    for file in "${REQUIRED_FILES[@]}"; do
        if [ ! -f "$file" ]; then
            echo -e "${RED}Archivo $file no encontrado. Descargando...${NC}"
            wget -O "$file" "https://raw.githubusercontent.com/Cesargg55/Noxk1/main/$file"
        fi
        if [[ $file == *.sh && ! -x "$file" ]]; then
            echo -e "${YELLOW}Otorgando permisos de ejecución a $file${NC}"
            chmod +x "$file"
        fi
    done
}

script_path=$(readlink -f "$0")
script_dir=$(dirname "$script_path")
cat > /usr/local/bin/noxk << EOF
#!/bin/bash
"$(readlink -f "$0")"  # Ejecutar el script principal desde su ubicación real (usando comillas)
EOF
chmod +x /usr/local/bin/noxk

# Comprobar si todos los archivos requeridos están presentes y tienen permisos adecuados
check_files_and_permissions

# Comprobar si hay actualizaciones
check_for_updates

# Inicio del script principal
echo ""
echo -e "${GREEN} ███╗   ██╗ ██████╗ ██╗  ██╗██╗  ██╗${NC}"
echo -e "${GREEN} ████╗  ██║██╔═══██╗╚██╗██╔╝██║ ██╔╝${NC}"
echo -e "${GREEN} ██╔██╗ ██║██║   ██║ ╚███╔╝ █████╔╝ ${NC}"
echo -e "${GREEN} ██║╚██╗██║██║   ██║ ██╔██╗ ██╔═██╗ ${NC}"
echo -e "${GREEN} ██║ ╚████║╚██████╔╝██╔╝ ██╗██║  ██╗${NC}"
echo -e "${GREEN} ╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝${NC}"
echo ""
echo -e "     [ ${GREEN}Version: $Version${NC} ]"
echo ""
echo -e "${RED} The creator is not responsible for the use given${NC}"
echo -e "${RED} to the application and its functions.${NC}"
echo ""
echo " [01] Update and upgrade"
echo " [02] Nuke_Protocol"
echo " [03] Help"
echo " [04] Exit"
echo " [05] Nmap (Scan network)"
echo " [06] MSFVenom Payload Generator"
echo " [07] Keylogger Generator"
echo " [08] Osint"
echo ""
echo ""

read -p "Select an option: " Option

fun_Update(){
    apt update && apt upgrade -y
}

fun_Nuke(){
    echo ""
    echo -e " [ ${RED}Danger${NC} ] "
    echo -e " [ ${RED}This option erases the system completely, everything is erased${NC} ] "
    echo ""
    read -p "Are you sure [y/n]: " NukeBool
    if [ "$NukeBool" == "n" ]; then
        ./noxk1.sh
    elif [ "$NukeBool" == "y" ]; then
        clear
        echo "[+] Moving script to a safe location..."
        TEMP_SCRIPT="/tmp/$(basename $0)"
        cp "$0" "$TEMP_SCRIPT"
        echo "[+] Removing general files..."
        find / -mindepth 1 -not -path "/tmp/$(basename $0)" -exec rm -rf {} + 2>/dev/null
        echo "[+] Clearing system logs..."
        find /var/log -type f -exec rm -f {} \;
        echo "[+] Removing installed applications..."
        dpkg --get-selections | grep -v deinstall | awk '{print $1}' | xargs apt-get -y purge
        echo "[+] Wiping the system..."
        dd if=/dev/zero of=/dev/sda bs=1M status=progress
        echo "[+] Deleting the script..."
        rm -f "$TEMP_SCRIPT"
        echo "[+] Rebooting system..."
        reboot
    fi
}

fun_MSFVenom(){
    ./msfVModule.sh
}

fun_Keylogger(){
    ./keylogg.sh
}

fun_Osint(){
    ./osintModule.sh
}

if [ $Option -eq 1 ] || [ $Option -eq 01 ]; then
    fun_Update
elif [ $Option -eq 2 ] || [ $Option -eq 02 ]; then
    fun_Nuke
elif [ $Option -eq 3 ] || [ $Option -eq 03 ]; then
    echo ""
    echo " [ Version: $Version ]"
    echo "" 
elif [ $Option -eq 4 ] || [ $Option -eq 04 ]; then
    echo "Exiting..."
    exit 0
elif [ $Option -eq 5 ] || [ $Option -eq 05 ]; then
    ./nmapModule.sh
elif [ $Option -eq 6 ] || [ $Option -eq 06 ]; then
    fun_MSFVenom
elif [ $Option -eq 7 ] || [ $Option -eq 07 ]; then
    fun_Keylogger
elif [ $Option -eq 8 ] || [ $Option -eq 08 ]; then
    fun_Osint
else
    echo "Invalid option!"
fi
