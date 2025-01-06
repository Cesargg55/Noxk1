#update.sh
function loading_animation {
  for i in 1 2 3; do
    echo "Actualizando$i."
    sleep 1
    clear
  done
}

loading_animation

wget -O nmapModule.sh https://raw.githubusercontent.com/Cesargg55/Noxk1/main/nmapModule.sh
wget -O noxk1.sh https://raw.githubusercontent.com/Cesargg55/Noxk1/main/noxk1.sh

chmod +x nmapModule.sh noxk1.sh

echo "Actualización completada. Reinicia el script para usar la nueva versión."
./noxk1.sh
