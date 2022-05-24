#!/usr/bin/env bash



uninstall() {

    #### TÍTULO ####

    echo -e ""
    echo -e "  \033[1m=================================================================\033[0m"
    echo -e "  \033[1m|       DESINSTALANDO \"ACTUALIZACIÓN AUTOMÁTICA CON APT\"        |\033[0m"
    echo -e "  \033[1m=================================================================\033[0m"
    echo -e "   version 1.1.0"



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
        echo -e ""
        echo -e "  * Presione \033[1mESC\033[0m para evitar que esta ventana se cierre dentro de 1 minuto."
        echo -e ""

        t_now=$(date +%s)
        t_end=$(date --date="+60 sec" +%s)

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



    #### COMPROBACIONES ####

    directorio=0
    anacron_reg=0
    comando=0

    # Comprovación de la existencia del directorio "$HOME/.local/share/daily-apt-autoupdate".
    if [[ -e $HOME/.local/share/daily-apt-autoupdate ]]; then
        directorio=1
    fi

    # Comprovación de la existencia del registro en "/etc/anacrontab".
    if [[ $(grep daily-apt-autoupdate-$USER /etc/anacrontab) != "" ]]; then
        anacron_reg=1
    fi

    # Comprovación de la existencia del enlace en "$HOME/.local/bin/daily-apt-autoupdate".
    if [[ -L $HOME/.local/bin/daily-apt-autoupdate ]]; then
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
    if [[ -e $HOME/.local/share/daily-apt-autoupdate ]]; then
        echo -e "Eliminando el directorio \033[1m$HOME/.local/share/daily-apt-autoupdate\033[0m y su contenido."
        rm -fr $HOME/.local/share/daily-apt-autoupdate
    else
        echo -e "No se ha encontrado el directorio \033[1m$HOME/.local/share/daily-apt-autoupdate\033[0m para poder borrarlo."
    fi

    # Borrando el registro de Anacron.
    if [[ $(grep daily-apt-autoupdate-$USER /etc/anacrontab) != "" ]]; then
        echo -e "Borrando el registro del usuario \033[1m$USER\033[0m en \033[1m/etc/anacrontab\033[0m."
        sudo sed -i "/daily-apt-autoupdate-$USER/d" /etc/anacrontab
    else
        echo -e "No se ha encontrado el registro en \033[1m/etc/anacrontab\033[0m para poder borrarlo."
    fi

    # Borrando el comando.
    if [[ -L $HOME/.local/bin/daily-apt-autoupdate ]]; then
        echo -e "Eliminando el comando \033[1mdaily-apt-autoupdate\033[0m de su usuario."
        rm $HOME/.local/bin/daily-apt-autoupdate
    else
        echo -e "No se ha encontrado el comando \033[1mdaily-apt-autoupdate\033[0m en su usuario."
    fi

    exito

    #### FIN ####
}



# Permite que el script se ejecute en su propia ventana de terminal con un simple doble click.
source ./assets/default-term.sh
export -f uninstall

if [[ $XDG_CURRENT_DESKTOP == *"GNOME"* ||  $XDG_CURRENT_DESKTOP == *"XFCE"* ]]; then
    uninstall
else
    $default_term uninstall
fi
