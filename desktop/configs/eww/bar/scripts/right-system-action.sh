#!/usr/bin/env sh

if [ "$RIGHT_SYSTEM_WORKER" != "1" ]; then
    RIGHT_SYSTEM_WORKER=1 "$0" "$@" >/dev/null 2>&1 &
    exit 0
fi

case "$1" in
    lock)
        hyprlock
        ;;
    reboot)
        systemctl reboot
        ;;
    poweroff)
        systemctl poweroff
        ;;
    audio)
        pavucontrol
        ;;
    wifi)
        nmgui
        ;;
esac
