#!/usr/bin/env bash

scripts=~/.config/hypr/scripts
locker=swaylock

if [[ -n $(pidof $locker) ]];then
  exit
fi

function lock() {
  killall -SIGUSR2 waybar
  # pactl set-sink-mute @DEFAULT_SINK@ toggle
  playerctl stop
  sleep 0.15s
  hyprctl dispatch workspace empty
  sleep 0.15s
  $locker
  killall -SIGUSR1 waybar
}


if [[ $1 == "--startup" ]];then
  sleep 1s
  $locker
  sh $scripts/sound.sh --startup
elif [[ $1 == "--idle" ]];then
  sh $scripts/sound.sh --lock
  lock
  sh $scripts/sound.sh --resume
else
  lock
fi

