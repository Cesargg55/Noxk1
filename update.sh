#update.sh
echo "Actualizando..."
wget -O nmapModule.sh https://raw.githubusercontent.com/Cesargg55/Noxk1/main/nmapModule.sh
wget -O noxk1.sh https://raw.githubusercontent.com/Cesargg55/Noxk1/main/noxk1.sh
wget -O osintModule.sh https://raw.githubusercontent.com/Cesargg55/Noxk1/main/osintModule.sh
wget -O msfVModule.sh https://raw.githubusercontent.com/Cesargg55/Noxk1/main/msfVModule.sh
wget -O keylogg.sh https://raw.githubusercontent.com/Cesargg55/Noxk1/main/keylogg.sh
wget -O Keylogg/WindowsKey.cpp https://raw.githubusercontent.com/Cesargg55/Noxk1/main/Keylogg/WindowsKey.cpp
chmod +x nmapModule.sh noxk1.sh msfVModule.sh keylogg.sh
echo "Actualización completada. Reinicia el script para usar la nueva versión."
./noxk1.sh
