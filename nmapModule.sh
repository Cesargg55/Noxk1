#!/bin/bash
clear

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${BLUE}"

echo ""
echo "  ███▄    █  ███▄ ▄███▓ ▄▄▄       ██▓███  "
echo "  ██ ▀█   █ ▓██▒▀█▀ ██▒▒████▄    ▓██░  ██▒"
echo " ▓██  ▀█ ██▒▓██    ▓██░▒██  ▀█▄  ▓██░ ██▓▒"
echo " ▓██▒  ▐▌██▒▒██    ▒██ ░██▄▄▄▄██ ▒██▄█▓▒ ▒"
echo " ▒██░   ▓██░▒██▒   ░██▒ ▓█   ▓██▒▒██▒ ░  ░"
echo " ░ ▒░   ▒ ▒ ░ ▒░   ░  ░ ▒▒   ▓▒█░▒▓▒░ ░  ░"
echo " ░ ░░   ░ ▒░░  ░      ░  ▒   ▒▒ ░░▒ ░     "
echo "    ░   ░ ░ ░      ░     ░   ▒   ░░       "
echo ""
echo -e "${NC}"
echo "            [Select an option]"
echo ""
echo -e "${RED} The creator is not responsible for the use given${NC}"
echo -e "${RED} to the application and its functions.${NC}"
echo ""
echo " [01] Scan Network"
echo " [02] Scan Specific IP"
echo " [03] Scan for Vulnerabilities"
echo ""

read -p "Select an option: " Option

fun_scanVuln() {
    read -p "Enter the target IP or hostname: " target

    echo ""
    echo " Select vulnerability scan type:"
    echo " [01] Basic vulnerability scan"
    echo " [02] Intense vulnerability scan (may take longer)"
    echo ""
    read -p "Choose scan type: " vulnMode

    case $vulnMode in
        1 | 01)
            echo "Starting basic vulnerability scan on $target..."
            nmap -sV --script vuln $target
            ;;
        2 | 02)
            echo "Starting intense vulnerability scan on $target..."
            nmap -sV --script=vuln,safe,exploit,discovery $target
            ;;
        *)
            echo "Invalid option. Exiting..."
            exit 1
            ;;
    esac
}

fun_scanN() {
    read -p "Scan (ip/24): " Netw

    echo ""
    echo " Select scan mode:"
    echo " [01] Paranoid (Stealth)"
    echo " [02] Normal"
    echo " [03] Detect SO"
    echo ""
    read -p "Choose scan mode: " Mode

    case $Mode in
        1 | 01)
            echo "Starting Paranoid scan on $Netw..."
            nmap -sS -T0 -Pn --scan-delay 500ms $Netw
            ;;
        2 | 02)
            echo "Starting Normal scan on $Netw..."
            nmap -sS -T4 $Netw
            ;;
        3 | 03)
            echo "Starting OS Detection scan on $Netw..."
            nmap -sS -A -T4 $Netw
            ;;
        *)
            echo "Invalid option. Exiting..."
            exit 1
            ;;
    esac
}

fun_scanIP() { 
    read -p "Enter the target IP: " targetIP

    echo ""
    echo " Select scan mode:"
    echo " [01] All ports"
    echo " [02] Common ports"
    echo " [03] Specific ports (comma-separated)"
    echo " [04] Paranoid (Stealth)"
    echo ""
    read -p "Choose scan mode: " portMode

    case $portMode in
        1 | 01)
            echo "Starting scan on all ports of $targetIP..."
            nmap -p- $targetIP 
            ;;
        2 | 02)
            echo "Starting scan on common ports of $targetIP..."
            nmap $targetIP 
            ;;
        3 | 03)
            read -p "Enter specific ports to scan (comma-separated): " specificPorts
            echo "Starting scan on specific ports ($specificPorts) of $targetIP..."
            nmap -p $specificPorts $targetIP 
            ;;
        4 | 04)
            echo "Starting Paranoid (Stealth) scan on $targetIP..."
            nmap -sS -T0 -Pn --scan-delay 500ms $targetIP
            ;;
        *)
            echo "Invalid option. Exiting..."
            exit 1
            ;;
    esac
}

if [ "$Option" -eq 1 ] || [ "$Option" -eq 01 ]
then
    fun_scanN
elif [ "$Option" -eq 2 ] || [ "$Option" -eq 02 ]
then
    fun_scanIP
elif [ "$Option" -eq 3 ] || [ "$Option" -eq 03 ]
then
    fun_scanVuln
else
    echo "Invalid option selected. Exiting..."
    exit 1
fi
