#!/usr/bin/env bash

get_status() {
    if rfkill list bluetooth | grep -q "Soft blocked: yes"; then
        echo "1" # Иконка выключенного BT (FontAwesome / Nerd Fonts)
    elif bluetoothctl show | grep -q "Powered: yes"; then
        if bluetoothctl info | grep -q "Connected: yes"; then
            echo "2" # Подключено устройство
        else
            echo "3" # Включено, но не подключено
        fi
    else
        echo "4"
    fi
}

get_status

# Отслеживание изменений в реальном времени через bluetoothctl
bluetoothctl monitor | while read -r; do
    get_status
done
