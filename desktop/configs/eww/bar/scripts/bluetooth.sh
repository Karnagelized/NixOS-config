#!/usr/bin/env bash

get_status() {
    if rfkill list bluetooth | grep -q "Soft blocked: yes"; then
        echo "󰂲" # Выключен
    elif bluetoothctl show | grep -q "Powered: yes"; then
        # Ищем подключенные устройства
        mapfile -t connected_devices < <(bluetoothctl devices Connected | awk '{print $2}')

        if [ ${#connected_devices[@]} -gt 0 ]; then
            # Берем первое подключенное устройство для отображения заряда
            local dev="${connected_devices[0]}"
            # Получаем процент заряда (ищем строку Battery Percentage)
            local battery
            battery=$(bluetoothctl info "$dev" | grep "Battery Percentage" | awk -F '[()]' '{print $2}')

            echo "󰂰" # Подключено, но заряд неизвестен
        else
            echo "󰂳" # Включен, но не подключен
        fi
    else
        echo "󰂲"
    fi
}

# Первый запуск при старте eww
get_status

# Мониторинг изменений (подключения устройств и изменения уровня батареи)
bluetoothctl monitor | while read -r line; do
    # Перерисовываем интерфейс, если изменились свойства устройства или статус подключения
    if echo "$line" | grep -qE "PropertiesChanged|Device|Connected"; then
        get_status
    fi
done
