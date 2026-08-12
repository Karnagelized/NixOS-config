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
        if command -v nm-connection-editor >/dev/null 2>&1; then
            nm-connection-editor
        elif command -v nm-applet >/dev/null 2>&1; then
            nm-applet
        else
            kitty -e nmtui
        fi
        ;;
esac
