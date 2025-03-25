#!/bin/bash

if ! command -v rofi &> /dev/null; then
    zenity --error --text="O Rofi não está instalado. Por favor, instale-o para usar este script."
    exit 1
fi

choice=$(echo -e "⏻ Desligar\n↻ Reiniciar\n⏸ Suspender\n⏹ Logoff\n❌ Cancelar" | rofi -dmenu -i -width 300 -lines 5 -theme gruvbox-dark-hard -p "Power Menu")

case "$choice" in
    "⏻ Desligar")
        shutdown now
        ;;
    "↻ Reiniciar")
        reboot
        ;;
    "⏸ Suspender")
        systemctl suspend
        ;;
    "⏹ Logoff")
        pkill -KILL -u $USER
        ;;
    "❌ Cancelar")
        exit 0
        ;;
    *)
        ;;
esac
