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
elif [[ $default_term == "konsole" ]];then
    default_term="konsole --hide-menubar -e bash -ic"
elif [[ $default_term == "terminator" ]];then
    default_term="$default_term -x bash -ic"
else
    default_term="$default_term -e bash -ic"
fi
