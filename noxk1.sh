#!/bin/bash

# Verificar si el script se está ejecutando como root
if [ "$EUID" -ne 0 ]
then 
    echo "Este script debe ejecutarse como root. Saliendo..."
    exit 1
fi

clear

Version=0.1.1  # Aquí eliminé los espacios alrededor del '='

# Colores ANSI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color (reset)


check_for_updates() { 

    latest_version=$(curl -s https://raw.githubusercontent.com/Cesargg55/Noxk1/main/version.txt)

    if [ "$latest_version" != "$Version" ]; then
        echo -e "${YELLOW}Nueva versión disponible: $latest_version${NC}"
        read -p "Deseas actualizar? [s/n]: " update_choice

        if [ "$update_choice" == "s" ]; then
            echo "Actualizando..."

            # Descargar los scripts actualizados (asegúrate de ajustar las URLs)
            wget -O nmapModule.sh nmapModule.sh https://raw.githubusercontent.com/Cesargg55/Noxk1/main/nmapModule.sh
            wget -O noxk1.sh nmapModule.sh https://raw.githubusercontent.com/Cesargg55/Noxk1/main/noxk1.sh

            echo "Actualización completada. Reinicia el script para usar la nueva versión."
            exit 0
        fi
    fi
}

check_for_updates

echo ""
echo -e "${GREEN} ███╗   ██╗ ██████╗ ██╗  ██╗██╗  ██╗${NC}"
echo -e "${GREEN} ████╗  ██║██╔═══██╗╚██╗██╔╝██║ ██╔╝${NC}"
echo -e "${GREEN} ██╔██╗ ██║██║   ██║ ╚███╔╝ █████╔╝ ${NC}"
echo -e "${GREEN} ██║╚██╗██║██║   ██║ ██╔██╗ ██╔═██╗ ${NC}"
echo -e "${GREEN} ██║ ╚████║╚██████╔╝██╔╝ ██╗██║  ██╗${NC}"
echo -e "${GREEN} ╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝${NC}"
echo ""
echo -e "     [ ${GREEN}Version: $Version${NC} ]"
echo ""
echo ""
echo " [01] Update and upgrade"
echo " [02] Nuke_Protocol"
echo " [03] Help"
echo " [04] Exit"
echo " [05] Nmap (Scan network)"
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
    if [ "$NukeBool" == "n" ]
    then
        ./noxk1.sh
    elif [ "$NukeBool" == "y" ]
    then
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

if [ $Option -eq 1 ] || [ $Option -eq 01 ]
then
    fun_Update
elif [ $Option -eq 2 ] || [ $Option -eq 02 ]
then
    fun_Nuke
elif [ $Option -eq 3 ] || [ $Option -eq 03 ]
then
    echo ""
    echo " [ Version: $Version ]"
    echo "" 
    
elif [ $Option -eq 4 ] || [ $Option -eq 04 ]
then
    echo "Exiting..."
    exit 0
elif [ $Option -eq 5 ] || [ $Option -eq 05 ]
then
    ./nmapModule.sh
else
    echo "Invalid option!"
fi