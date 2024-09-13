#!/bin/bash
clear

# Function to check if OsintGram is installed
function is_osintgram_installed() {
  command -v osintgram >/dev/null 2>&1
}

# Function to install OsintGram (replace with placeholders)
function install_osintgram() {
  echo "OsintGram is not installed. Installing..."

  # **Important:** Replace these placeholders with actual installation commands for your system
  # **Debian/Ubuntu:**
  if [[ "$(lsb_release -is)" == "Ubuntu" || "$(lsb_release -is)" == "Debian" ]]; then
    echo "Detected Ubuntu/Debian. Attempting installation using package manager..."
    sudo apt update && sudo apt install osintgram
  # **Fedora/CentOS/RHEL:**
  elif [[ "$(cat /etc/os-release | grep -w '^ID=' | cut -d= -f2)" == "fedora" || "$(cat /etc/os-release | grep -w '^ID=' | cut -d= -f2)" == "centos" || "$(cat /etc/os-release | grep -w '^ID=' | cut -d= -f2)" == "rhel" ]]; then
    echo "Detected Fedora/CentOS/RHEL. Attempting installation using package manager..."
    sudo dnf update && sudo dnf install osintgram
  # **Provide alternative installation instructions for other distributions**
  else
    echo "**Warning:** Automatic installation not supported for your distribution."
    echo "Please refer to the official OsintGram documentation for installation instructions: https://docs.osintgram.com/installation/"
  fi

  # Check if installation was successful
  if ! is_osintgram_installed; then
    echo "**Error:** Installation failed. Please check the output above for details."
  fi
}

echo ""
echo "Select the type of Osint:"
echo ""

# Check for OsintGram installation and display options accordingly
if is_osintgram_installed; then
  echo " [01] Osintgram"
  echo " [02] Other tool (coming soon)"
else
  echo " [01] Install OsintGram"
  echo " [02] Other tool (coming soon)"
fi

echo ""
read -p "Select an option: " OsintOption


function osintgram()
{

}

case $OsintOption in
  1 | 01)
    if is_osintgram_installed; then
        osintgram
    else
      read -p "OsintGram is not installed. Install it now? (y/N): " install_choice
      if [[ $install_choice =~ ^[Yy]$ ]]; then
        install_osintgram
      fi
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