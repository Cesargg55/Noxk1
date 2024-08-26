#!/bin/bash

clear

# Cabecera ASCII art
echo ""
echo " █████   ████                     █████                                                         "
echo "░░███   ███░                     ░░███                                                          "
echo " ░███  ███     ██████  █████ ████ ░███         ██████   ███████  ███████  ██████  ████████      "
echo " ░███████     ███░░███░░███ ░███  ░███        ███░░███ ███░░███ ███░░███ ███░░███░░███░░███     "
echo " ░███░░███   ░███████  ░███ ░███  ░███       ░███ ░███░███ ░███░███ ░███░███████  ░███ ░░░      "
echo " ░███ ░░███  ░███░░░   ░███ ░███  ░███      █░███ ░███░███ ░███░███ ░███░███░░░   ░███          "
echo " █████ ░░████░░██████  ░░███████  ███████████░░██████ ░░███████░░███████░░██████  █████         "
echo "░░░░░   ░░░░  ░░░░░░    ░░░░░███ ░░░░░░░░░░░  ░░░░░░   ░░░░░███ ░░░░░███ ░░░░░░  ░░░░░          "
echo "                       ███ ░███                       ███ ░███ ███ ░███                         "
echo "                       ░░██████                       ░░██████ ░░██████                         "
echo "                        ░░░░░░                         ░░░░░░   ░░░░░░                          "
echo ""

# Opciones de selección
echo "Please select the target operating system:"
echo " [01] Windows"
echo " [02] Linux"
echo " [03] Android"
echo ""
read -p "Select an option: " osOption

case $osOption in
    1 | 01)
        echo ""
        echo " [01] Simple Windows"
        echo " [02] Complex Windows"
        echo ""
        read -p "Select an option: " osOptionWind
        echo ""
        echo "Creating Windows keylogger..."
        
        case $osOptionWind in 
        1 | 01)
            if [ -f "Python/Keylogger/WindowsKey.py" ]; then
                python3 Python/Keylogger/WindowsKey.py
            else
                echo "Error: WindowsKey.py not found!"
            fi
            ;;
        2 | 02)
            if [ -f "Python/Keylogger/WindowsKeyComplex.py" ]; then
                python3 Python/Keylogger/WindowsKeyComplex.py
            else
                echo "Error: WindowsKeyComplex.py not found!"
            fi
            ;;
        *)
            echo "Invalid option for Windows keylogger."
            ;;
        esac
        ;;
    2 | 02)
        echo "Creating Linux keylogger..."
        # Aquí añadirías el código para crear un keylogger para Linux
        ;;
    3 | 03)
        echo "Creating Android keylogger..."
        # Aquí añadirías el código para crear un keylogger para Android
        ;;
    *)
        echo "Invalid option. Exiting..."
        ;;
esac

echo ""
read -p "Press any key to exit..."
./noxk1.sh
