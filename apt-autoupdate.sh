#!/usr/bin/env bash



#### TÍTULO ####

echo -e ""
    echo -e "  \033[1m=================================================================\033[0m"
echo -e "  \033[1m|               ACTUALIZACIÓN AUTOMÁTICA CON APT                |\033[0m"
    echo -e "  \033[1m=================================================================\033[0m"
echo -e ""



#### MENSAJES ####

fallo() {
    echo -e ""
    echo -e ""
    echo -e "  \033[1m=================================================================\033[0m"
    echo -e "  \033[1m|\033[41m                             ERROR                             \033[0m\033[1m|\033[0m"
    echo -e "  \033[1m=================================================================\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m Las actualizaciones han fallado en el proceso:                \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                       $1                        \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m El fallo se puede deber a algún problema puntual$2             \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m Si el fallo se sigue repitiendo durante varios dias seguidos, \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m pongase en contacto con su administrador.                     \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m---------------------------------------------------------------\033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m Para salir presione \033[7;5;1m ENTER \033[0m o cierre la ventana.              \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m=================================================================\033[0m"
    echo -e ""

    read cerrar
    exit
}

permisos() {
    echo -e "  \033[1m=================================================================\033[0m"
    echo -e "  \033[1m|\033[41m                       ERROR DE PERMISOS                       \033[0m\033[1m|\033[0m"
    echo -e "  \033[1m=================================================================\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m Necesita ejecutar este fichero como \033[1mSUDO\033[0m.                     \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m=================================================================\033[0m"
    echo -e ""
    echo -e "Introduzca la contraseña de \033[1msu usuario\033[0m para permitir las actualizaciones."

    sudo echo ""
}

exito() {
    echo -e ""
    echo -e ""
    echo -e "  \033[1m=================================================================\033[0m"
    echo -e "  \033[1m|\033[42m                    ACTUALIZACIÓN TERMINADA                    \033[0m\033[1m|\033[0m"
    echo -e "  \033[1m=================================================================\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m Las actualizaciones se han llevado a cabo con exito.          \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m---------------------------------------------------------------\033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m Para salir presione \033[7;5;1m ENTER \033[0m o cierre la ventana.              \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m=================================================================\033[0m"
    echo -e ""
    
    read -t 60 cerrar
    exit
}



#### COMPROBACIONES ####

# Verificación de permisos avanzados (root/sudo).
if [[ $(id -u) != 0 ]]; then
    permisos
fi

# Verificación de conexión con Internet.
ping -c 1 linux.org &> /dev/null

if [[ $? != 0 ]]; then      # Capturar fallo
    fallo "    \033[7;1m \"UPDATE\" \033[0m  " " o a la       \033[1m|\n  | \033[31mfalta de conexión a internet\033[0m.                    "
fi



#### PROGRAMA ####

echo -e "    \033[1m==== UPDATE ====\033[0m"
echo -e ""

sudo apt update 2> /dev/null

if [[ $? != 0 ]]; then      # Capturar fallo
    fallo "    \033[7;1m \"UPDATE\" \033[0m  " "."
fi

echo -e ""
echo -e "    \033[1m==== FULL-UPGRADE ====\033[0m"
echo -e ""

sudo apt full-upgrade -y 2> /dev/null

if [[ $? != 0 ]]; then      # Capturar fallo
    fallo "\033[7;1m \"FULL-UPGRADE\" \033[0m" "."
fi

echo -e ""
echo -e "    \033[1m==== AUTOREMOVE ====\033[0m"
echo -e ""

sudo apt autoremove --purge -y 2> /dev/null

if [[ $? != 0 ]]; then      # Capturar fallo
    fallo " \033[7;1m \"AUTOREMOVE\" \033[0m " "."
fi

echo -e ""
echo -e "    \033[1m==== AUTOCLEAN ====\033[0m"
echo -e ""

sudo apt autoclean 2> /dev/null

if [[ $? != 0 ]]; then      # Capturar fallo
    fallo " \033[7;1m \"AUTOCLEAN\" \033[0m  " "."
fi

exito

#### FIN ####
