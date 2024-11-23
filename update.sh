#update.sh
function loading_animation {
  for i in 1 2 3; do
    echo "Actualizando$i."
    clear
    sleep 1
  done
}

loading_animation

wget -O nmapModule.sh https://raw.githubusercontent.com/Cesargg55/Noxk1/main/nmapModule.sh
wget -O noxk1.sh https://raw.githubusercontent.com/Cesargg55/Noxk1/main/noxk1.sh
wget -O arp_scan.sh https://raw.githubusercontent.com/Cesargg55/Noxk1/main/arp_scan.sh
wget -O osintModule.sh https://raw.githubusercontent.com/Cesargg55/Noxk1/main/osintModule.sh
wget -O msfVModule.sh https://raw.githubusercontent.com/Cesargg55/Noxk1/main/msfVModule.sh

chmod +x nmapModule.sh noxk1.sh arp_scan.sh msfVModule.sh osintModule.sh

echo "Actualización completada. Reinicia el script para usar la nueva versión."
./noxk1.sh
