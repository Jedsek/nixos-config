#!/usr/bin/env bash

low_battery=20
very_low_battery=10
duration="1m"

scripts_dir=~/.config/hypr/scripts

check_battery() {
  current_battery=$(upower --dump | grep percentage | cut -c 26- | head -n 1)
  current_battery="${current_battery%?}"
  battery_state=$(upower --dump | grep state | cut -c 26- | head -n 1)

  if [[ $battery_state == "discharging" ]];then
    if [[ $current_battery -le $low_battery && $current_battery -gt $very_low_battery ]];then
      sh $scripts_dir/sound.sh --low-battery
      brightnessctl s 45%-
    fi

    if [[ $current_battery -le $very_low_battery ]];then
      sh $scripts_dir/sound.sh --very-low-battery
      brightnessctl s 45%-
    fi

    sleep 5m
  fi

}

while true;do
  check_battery
  sleep $duration
done
