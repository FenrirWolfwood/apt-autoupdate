#!/usr/bin/env bash



# Permite que el script se ejecute en su propia ventana de terminal con un simple doble click.
# Selecciona el último terminal que coincida de la lista.

default_term="N/A"

case $XDG_CURRENT_DESKTOP in
    *"GNOME"*)
        default_term="gnome-terminal" ;;
    "KDE")
        default_term="konsole" ;;
    "XFCE")
        default_term="xfce4-terminal" ;;
    "X-Cinnamon")
        default_term="gnome-terminal" ;;
    *)
        for terminal in "$TERMINAL" yakuake guake tilda terminator urxvt rxvt termit Eterm roxterm termite lxterminal terminology st qterminal lilyterm tilix terminix kitty alacritty hyper xterm uxterm aterm mate-terminal xfce4-terminal konsole gnome-terminal x-terminal-emulator; do
            if command -v "$terminal" > /dev/null 2>&1; then
                default_term="$terminal"
            fi
        done ;;
esac

if [[ $default_term == "konsole" ]]; then
    default_term="konsole --hide-menubar -p tabtitle=daily-apt-autoupdate -e bash -ic"
elif [[ $default_term == "gnome-terminal" ]]; then
    default_term="gnome-terminal --hide-menubar --title=daily-apt-autoupdate -- bash -ic"
elif [[ $default_term == "xfce4-terminal" ]]; then
    default_term="xfce4-terminal --disable-server --hide-menubar --title=daily-apt-autoupdate -x bash -ic"
elif [[ $default_term == "terminator" ]]; then
    default_term="$default_term -x bash -ic"
else
    default_term="$default_term -e bash -ic"
fi
