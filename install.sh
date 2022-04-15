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
echo -e "  \033[1m|        INSTALANDO \"ACTUALIZACIÓN AUTOMÁTICA CON APT\"          |\033[0m"
echo -e "  \033[1m=================================================================\033[0m"
echo -e ""



#### MENSAJES ####

advertencia() {
    echo -e ""
    echo -e "  \033[1m=================================================================\033[0m"
    echo -e "  \033[1m|\033[43m                           ATENCIÓN!                           \033[0m\033[1m|\033[0m"
    echo -e "  \033[1m=================================================================\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m Va a instalar el programa de \033[1mACTUALIZACIÓN AUTOMÁTICA         |\033[0m"
    echo -e "  \033[1m|\033[0m \033[1mCON APT\033[0m.                                                      \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m Esto permitirá que se actualize su sistema de forma           \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m automática a diario.                                          \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m También le mostrará una ventana informativa durante la        \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m actualización indicándole si todo ha ido bien o si ha habido  \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m algún problema.                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m Desea continuar?                                              \033[1m|\033[0m"
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

previa() {
    echo -e ""
    echo -e "  \033[1m=================================================================\033[0m"
    echo -e "  \033[1m|\033[41m                             ERROR                             \033[0m\033[1m|\033[0m"
    echo -e "  \033[1m=================================================================\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m Parece que ya existe una instalación previa.                  \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m Si esta no funciona correctamente ejecute \033[1muninstall.sh        |\033[0m"
    echo -e "  \033[1m|\033[0m para borrarla antes de intentarla volver a instalar.          \033[1m|\033[0m"
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

fallo() {
    echo -e ""
    echo -e ""
    echo -e "  \033[1m=================================================================\033[0m"
    echo -e "  \033[1m|\033[41m                             ERROR                             \033[0m\033[1m|\033[0m"
    echo -e "  \033[1m=================================================================\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m La instalación ha fallado por un motivo desconocido.          \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m FALLO: $1                           \033[1m|\033[0m"
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
    echo -e "  \033[1m|\033[42m                     INSTALACIÓN TERMINADA                     \033[0m\033[1m|\033[0m"
    echo -e "  \033[1m=================================================================\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m La instalación ha finalizado correctamente.                   \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m---------------------------------------------------------------\033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m Presione \033[7;5;1m ENTER \033[0m o cierre la ventana para salir.              \033[1m|\033[0m"
    echo -e "  \033[1m|\033[0m                                                               \033[1m|\033[0m"
    echo -e "  \033[1m=================================================================\033[0m"
    
    read -t 20 cerrar
    exit
}



#### COMPROBACIONES ####

# Comprovación de la existencia del directorio "/opt/apt-autoupdate".
if [[ -e /opt/apt-autoupdate ]]; then
     previa
fi

# Comprovación de la existencia del registro en "/etc/anacrontab".
if [[ $(grep apt-autoupdate /etc/anacrontab) != "" ]]; then
    previa
fi



#### INSTALACIÓN ####

advertencia

if [[ $choice == 1 ]]; then
    echo -e "\033[1m Instalación cancelada.\033[0m"
    sleep 1
    exit
fi

echo -e "Introduzca la contraseña de \033[1msu usuario\033[0m para autorizar que empiece la instalación."

sudo echo ""

# Creación del directorio y copia de los archivos.
echo -e "Creando el directorio \033[1m\"/opt/apt-autoupdate\"\033[0m y copiando los ficheros necesarios."

sudo mkdir /opt/apt-autoupdate

if [[ $? != 0 ]]; then      # Capturar fallo
    fallo "\033[1;31mCreación del directorio\033[0m.    "
fi

sudo cp -r * /opt/apt-autoupdate
sudo chmod +x /opt/apt-autoupdate/apt-autoupdate.sh /opt/apt-autoupdate/install.sh /opt/apt-autoupdate/uninstall.sh
sudo ln -s /opt/apt-autoupdate/apt-autoupdate.sh /usr/bin/apt-autoupdate

if [[ $? != 0 ]]; then      # Capturar fallo
    sudo rm -fr /opt/apt-autoupdate /usr/bin/apt-autoupdate
    fallo "\033[1;31mCopia de los ficheros\033[0m.      "
fi

echo -e "Copia de ficheros realizada con exito."
echo ""

# Programación de la taréa en /etc/anacriontab.
echo -e "Incluyendo el registro en \033[1mAnacron\033[0m para que se ejecute el script \033[1mdiariamente\033[0m a los 3 min de iniciar el sistema."

echo -e "1	3	apt-autoupdate	export DISPLAY=$DISPLAY && export XAUTHORITY=$HOME/.Xauthority && /opt/apt-autoupdate/apt-autoupdate.sh" | sudo tee -a /etc/anacrontab > /dev/null

if [[ $? != 0 ]]; then      # Capturar fallo
    sudo rm -fr /opt/apt-autoupdate /usr/bin/apt-autoupdate
    fallo "\033[1;31mIncluir tarea en anacrontab\033[0m."
fi

echo -e "El registro ha sido añadido a \033[1m/etc/anacrontab\033[0m con exito."

exito

#### FIN ####
'
