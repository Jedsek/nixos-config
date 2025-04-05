#!/usr/bin/env bash


# This script could control your default sink's volume
# This script has been checked with `shellcheck`
# 
# Usage:
# `sh volume.sh lower`
# `sh volume.sh raise`
# `sh volume.sh toggle-mute`
#
# Note:
# You should install command `pactl` && `wob` for dependencies


MIN_VOLUME=0
MAX_VOLUME=100
VOLUME_STEP=5
CURRENT_VOLUME=$(pactl get-sink-volume 0 | awk '{print $5}')
CURRENT_VOLUME="${CURRENT_VOLUME%?}"
WOBSOCK="$XDG_RUNTIME_DIR"/wob.sock

to_wob() {
  pactl get-sink-volume @DEFAULT_SINK@ | head -n 1| awk '{print substr($5, 1, length($5)-1)}' > "$WOBSOCK"
}

lower_volume() {
  CURRENT_VOLUME=$((CURRENT_VOLUME-VOLUME_STEP))
  if [[ $CURRENT_VOLUME -le $MIN_VOLUME ]];then
    CURRENT_VOLUME=$MIN_VOLUME
    pactl set-sink-mute @DEFAULT_SINK@ 1    
  else
    pactl set-sink-mute @DEFAULT_SINK@ 0
  fi
  pactl set-sink-volume @DEFAULT_SINK@ $CURRENT_VOLUME% && to_wob
}

raise_volume() {
  pactl set-sink-mute 0 0
  CURRENT_VOLUME=$((CURRENT_VOLUME+VOLUME_STEP))
  if [[ $CURRENT_VOLUME -gt $MAX_VOLUME ]];then
    CURRENT_VOLUME=$MAX_VOLUME
  fi
  pactl set-sink-volume @DEFAULT_SINK@ $CURRENT_VOLUME% && to_wob
}

toggle_mute() {
  if [[ $CURRENT_VOLUME != 0 ]];then
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    is_mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk "{print \$2}")
    if [[ $is_mute == "yes" ]];then
      echo 0 > "$WOBSOCK"
    else
      to_wob
    fi
  else
    echo 0 > "$WOBSOCK"
  fi
}


case $1 in
  lower)
    lower_volume
    ;;
  raise)
    raise_volume
    ;;
  toggle-mute)
    toggle_mute
    ;;
  *)
    echo "$XDG_CONFIG_HOME/$0: The argument is not found."
    ;;
esac