#!/usr/bin/env bash
get_battery_path() {
    local battery
    for battery in /sys/class/power_supply/BAT*; do
        [ -e "$battery" ] && {
            echo "$battery"
            return 0
        }
    done
    return 1
}

get_battery_percent() {
    local battery
    battery="$(get_battery_path)" || {
        echo "100"
        return
    }
    LC_ALL=C cat "$battery/capacity" 2>/dev/null || echo "100"
}

get_battery_status() {
    local battery
    battery="$(get_battery_path)" || {
        echo "Full"
        return
    }
    LC_ALL=C cat "$battery/status" 2>/dev/null || echo "Full"
}

get_battery_icon() {
    local percent=$(get_battery_percent)
    local status=$(get_battery_status)
    if ! get_battery_path >/dev/null; then
        echo "∞"
        return
    fi
    if [ "$status" = "Charging" ] || [ "$status" = "Full" ]; then
        if [ "$percent" -ge 90 ]; then echo "󰂅"
        elif [ "$percent" -ge 80 ]; then echo "󰂋"
        elif [ "$percent" -ge 60 ]; then echo "󰂊"
        elif [ "$percent" -ge 40 ]; then echo "󰢞"
        elif [ "$percent" -ge 20 ]; then echo "󰂆"
        else echo "󰢜"; fi
    else
        if [ "$percent" -ge 90 ]; then echo "󰁹"
        elif [ "$percent" -ge 80 ]; then echo "󰂂"
        elif [ "$percent" -ge 70 ]; then echo "󰂁"
        elif [ "$percent" -ge 60 ]; then echo "󰂀"
        elif [ "$percent" -ge 50 ]; then echo "󰁿"
        elif [ "$percent" -ge 40 ]; then echo "󰁾"
        elif [ "$percent" -ge 30 ]; then echo "󰁽"
        elif [ "$percent" -ge 20 ]; then echo "󰁼"
        elif [ "$percent" -ge 10 ]; then echo "󰁻"
        else echo "󰁺"; fi
    fi
}
jq -n -c --arg percent "$(get_battery_percent)" --arg status "$(get_battery_status)" --arg icon "$(get_battery_icon)" '{percent: $percent, status: $status, icon: $icon}'
