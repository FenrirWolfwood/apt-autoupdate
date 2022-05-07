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
    
    log_activity "FALLO" ": $3"

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

    if [[ $? != 0 ]]; then      # Capturar fallo
        echo -e ""
        echo -e "\033[1mLa contraseña no es correcta.\033[0m"
        log_activity "ERROR DE PERMISOS"
        exit
    fi
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
    echo -e "  * Presione \033[1mESC\033[0m para evitar que esta ventana se cierre dentro de 20 segundos."
    echo -e ""
    
    log_activity "EXITO"
    
    t_now=$(date +%s)
    t_end=$(date --date="+20 sec" +%s)
    
    while [ $t_now -lt $t_end ]; do
        IFS=""
        read -sn 1 -t $(($t_end - $t_now)) cerrar
        
        case $cerrar in
            $'\e')
                echo -e "  Cuando haya terminado presione \033[1mENTER\033[0m para salir."
                read cerrar
                exit ;;
            "")
                exit ;;
            *)
                : ;;
        esac
        t_now=$(date +%s)
    done
}

log_activity(){
    # Verificación de la existencia del log.
    if [[ ! -e $HOME/.local/share/daily-apt-autoupdate/activity.log ]]; then
        echo "=================================================================" >> $HOME/.local/share/daily-apt-autoupdate/activity.log
        echo "|            LOG DE ACTIVIDAD DE DAILY-APT-AUTOUPDATE           |" >> $HOME/.local/share/daily-apt-autoupdate/activity.log
        echo "=================================================================" >> $HOME/.local/share/daily-apt-autoupdate/activity.log
        sudo chown $USER:$GROUP $HOME/.local/share/daily-apt-autoupdate/activity.log
    fi
    
    # Verificación del tamaño del log (máximo 30 registros).
    if [[ $(wc -l < $HOME/.local/share/daily-apt-autoupdate/activity.log) -ge 33 ]]; then
        sed -i 4d $HOME/.local/share/daily-apt-autoupdate/activity.log
    fi
    
    # Registro de actividad.
    echo -e "$(date +"%a %d %b %Y - %H:%M:%S") ··· $1$2" >> $HOME/.local/share/daily-apt-autoupdate/activity.log
}



#### COMPROBACIONES ####

# Verificación de permisos avanzados (root/sudo).
if [[ $(id -u) != 0 ]]; then
    permisos
fi

# Verificación de conexión con Internet.
ping -c 1 linux.org &> /dev/null

if [[ $? != 0 ]]; then      # Capturar fallo
    fallo "    \033[7;1m \"UPDATE\" \033[0m  " " o a la       \033[1m|\n  | \033[31mfalta de conexión a internet\033[0m.                                 \033[1m|\n  |                                                               |\n  |\033[0m Puede ejecutar nuevamente este programa escribiendo           \033[1m|\n  | daily-apt-autoupdate\033[0m en una terminal.            " "Falta de conexión"
fi



#### PROGRAMA ####

echo -e "    \033[1m==== UPDATE ====\033[0m"
echo -e ""

sudo apt update 2> /dev/null

if [[ $? != 0 ]]; then      # Capturar fallo
    fallo "    \033[7;1m \"UPDATE\" \033[0m  " "." "Update"
fi

echo -e ""
echo -e "    \033[1m==== FULL-UPGRADE ====\033[0m"
echo -e ""

sudo apt full-upgrade -y 2> /dev/null

if [[ $? != 0 ]]; then      # Capturar fallo
    fallo "\033[7;1m \"FULL-UPGRADE\" \033[0m" "." "Full-upgrade"
fi

echo -e ""
echo -e "    \033[1m==== AUTOREMOVE ====\033[0m"
echo -e ""

sudo apt autoremove --purge -y 2> /dev/null

if [[ $? != 0 ]]; then      # Capturar fallo
    fallo " \033[7;1m \"AUTOREMOVE\" \033[0m " "." "Autoremove"
fi

echo -e ""
echo -e "    \033[1m==== AUTOCLEAN ====\033[0m"
echo -e ""

sudo apt autoclean 2> /dev/null

if [[ $? != 0 ]]; then      # Capturar fallo
    fallo " \033[7;1m \"AUTOCLEAN\" \033[0m  " "." "Autoclean"
fi

exito

#### FIN ####
