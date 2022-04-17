#!/usr/bin/env bash



# Permite que el script se ejecute en su propia ventana de terminal con un simple doble click.

default_term="N/A"

for terminal in "$TERMINAL" x-terminal-emulator mate-terminal gnome-terminal terminator xfce4-terminal urxvt rxvt termit Eterm aterm uxterm xterm roxterm termite lxterminal terminology st qterminal lilyterm tilix terminix konsole kitty guake tilda alacritty hyper; do
    if command -v "$terminal" > /dev/null 2>&1; then
        default_term="$terminal"
    fi
done

if [[ $default_term == "xfce4-terminal" ]];then
    default_term="xfce4-terminal --hide-menubar -x bash -ic"
elif [[ $default_term == "terminator" ]];then
    default_term="$default_term -x bash -ic"
else
    default_term="$default_term -e bash -ic"
fi

$default_term '



#### TÍTULO ####

echo -e ""
echo -e "  \033[1m=================================================================\033[0m"
echo -e "  \033[1m|       DESINSTALANDO \"ACTUALIZACIÓN AUTOMÁTICA CON APT\"        |\033[0m"
echo -e "  \033[1m=================================================================\033[0m"
echo -e ""



#### MENSAJE ####

advertencia() {
    echo -e ""
    echo -e "  \033[1m=================================================================\033[0m"
    echo -e "  \033[1m|\033[43m                           ATENCIÓN!                           \033[0m\033[1m|\033[0m"
    echo -e "  \033[1m=================================================================\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m Está a punto de desinstalar el programa de \033[1mACTUALIZACIÓN      |\033[0m"
    echo -e "  \033[1m|\033[0m \033[1mAUTOMÁTICA CON APT\033[0m.                                           \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m Esto significa que a partir de ahora su sistema tendrá que    \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m encargarse de las actualizaciones por sus propios medios o    \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m que usted deberá asumir la tarea de llevarlas a cabo          \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m \033[1mde forma manual\033[0m.                                              \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m Está usted seguro que desea continuar?                        \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m---------------------------------------------------------------\033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    
    options=("Si" "No")
    
    source ./assets/menu-si-no.sh
    select_option "${options[@]}"
    choice=$?
    
    echo -e ""
    echo -e ""
    echo -e ""
}

sin_previa() {
    echo -e ""
    echo -e "  \033[1m=================================================================\033[0m"
    echo -e "  \033[1m|\033[41m                             ERROR                             \033[0m\033[1m|\033[0m"
    echo -e "  \033[1m=================================================================\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m No se ha detectado una instalación previa.                    \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m Si le ha fallado la instalación al ejecutar el fichero        \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m \033[1minstall.sh\033[0m puede realizar la instalación de forma manual.     \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m Encontrará descritos los pasos para ello dentro de \033[1mREADME.md\033[0m. \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m---------------------------------------------------------------\033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m Presione \033[7;5;1m ENTER \033[0m o cierre la ventana para salir.              \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m=================================================================\033[0m"
    echo -e ""
    
    read cerrar
    exit
}

exito() {
    echo -e ""
    echo -e ""
    echo -e "  \033[1m=================================================================\033[0m"
    echo -e "  \033[1m|\033[42m                   DESINSTALACIÓN TERMINADA                    \033[0m\033[1m|\033[0m"
    echo -e "  \033[1m=================================================================\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m La desinstalación ha finalizado correctamente.                \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m---------------------------------------------------------------\033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m Presione \033[7;5;1m ENTER \033[0m o cierre la ventana para salir.              \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m=================================================================\033[0m"
    
    read -t 60 cerrar
    exit
}



#### COMPROBACIONES ####

directorio=0
anacron_reg=0
comando=0

# Comprovación de la existencia del directorio "/opt/apt-autoupdate".
if [[ -e /opt/apt-autoupdate ]]; then
     directorio=1
fi

# Comprovación de la existencia del registro en "/etc/anacrontab".
if [[ $(grep apt-autoupdate /etc/anacrontab) != "" ]]; then
    anacron_reg=1
fi

# Comprovación de la existencia del enlace en "/usr/bin/apt-autoupdate".
if [[ -L /usr/bin/apt-autoupdate ]]; then
     comando=1
fi

if [[ $(($directorio + $anacron_reg + $comando)) == 0 ]]; then
    sin_previa
fi

#### DESINSTALACIÓN ####

advertencia

if [[ $choice == 1 ]]; then
    echo -e "\033[1m Desinstalación cancelada.\033[0m"
    sleep 2
    exit
fi

echo -e "Introduzca la contraseña de \033[1msu usuario\033[0m para autorizar que empiece la desinstalación."

sudo echo ""

if [[ $? != 0 ]]; then      # Capturar fallo
    echo -e ""
    echo -e "\033[1mLa contraseña no es correcta.\033[0m"
    sleep 2
    exit
fi

# Borrando el directorio.
if [[ -e /opt/apt-autoupdate ]]; then
    echo -e "Eliminando el directorio \033[1m/opt/apt-autoupdate\033[0m y su contenido."
    sudo rm -fr /opt/apt-autoupdate
else
    echo -e "No se ha encontrado el directorio \033[1m/opt/apt-autoupdate\033[0m para poder borrarlo."
fi

# Borrando el comando.
if [[ -L /usr/bin/apt-autoupdate ]]; then
    echo -e "Eliminando el comando \033[1mapt-autoupdate\033[0m."
    sudo rm -fr /usr/bin/apt-autoupdate
else
    echo -e "No se ha encontrado el comando \033[1mapt-autoupdate\033[0m en su sistema."
fi

# Borrando el registro de Anacron.
if [[ $(grep apt-autoupdate /etc/anacrontab) != "" ]]; then
    echo -e "Borrando el registro de \033[1m/etc/anacrontab\033[0m."
    sudo sed -i '/apt-autoupdate/d' /etc/anacrontab
else
    echo -e "No se ha encontrado el registro en \033[1m/etc/anacrontab\033[0m para poder borrarlo."
fi

exito

#### FIN ####
'
