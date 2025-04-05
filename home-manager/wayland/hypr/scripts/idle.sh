#!/usr/bin/env bash

time_1=300

swayidle -w \
  timeout $time_1 'pactl set-sink-mute @DEFAULT_SINK@ toggle' \
  timeout $time_1 'playerctl stop' \
  timeout $time_1 'hyprctl dispatch workspace empty' \
  timeout $time_1 'hyprlock' \
  # timeout 600 'hyprctl dispatch dpms off' \
  #   resume 'hyprctl dispatch dpms on' \
  before-sleep 'sh ~/.config/hypr/scripts/sound.sh --sleep' \
  before-sleep 'hyprlock' &
