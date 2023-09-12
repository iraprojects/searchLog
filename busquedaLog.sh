#!/bin/bash

#--------------------------------------------------------------------------
#                                            |
# Script que permite buscar información relevante en un log del sistema.  |
#--------------------------------------------------------------------------

# Comprobar usuario
if [ $(whoami) != "root" ]; then
    echo "Necesitas ser usuario ROOT para ejecutar este script"
    exit 1
fi

pause(){
  read -p "Presiona [Enter] para continuar..." fackEnterKey
}

MENU="SELECCIONAR UNA OPCION DEL MENU: "
while :
do
  echo -e " \e[101;92m MENU PRINCIPAL \e[0m"
  PS3=$MENU

  select OPTION in "Buscar" "Mostrar todo" "salir"
  do
    case $REPLY in 
      1) # Buscar
        # Ejemplos de busqueda:
        # Buscar: 16/Mar/2020
        # Buscar: Chrome
        # Buscar: Windows
        # Buscar: Firefox
         echo -e "\e[30;107m $OPTION \e[0m"
         read -p "Buscar (Ejemplo: Linux): " BUSQUEDA
         more /var/log/apache2/access.log | cut -d " " -f4,2,6,7,8,13,14,15,18,20,22 | grep -i $BUSQUEDA
         pause
         clear
         break
         ;;
      2) # Mostrar todo
         echo -e " \e[30;107m $OPTION \e[0m"
         more /var/log/apache2/access.log | cut -d " " -f4,2,6,7,8,13,14,15,18,20,22
         pause
         clear
         break
         ;;
      3) # salir   
         clear
         break 2  #  sale del script
         ;;
      *) # tecla erronea
         echo -e "\e[1;31mHas pulsado una tecla erronea [${REPLY}]\e[0m"
         pause
         clear
         break
         ;;
    esac
  done
done

exit 0
