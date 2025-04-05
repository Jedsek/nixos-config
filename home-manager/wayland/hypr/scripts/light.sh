#!/usr/bin/env bash
WOBSOCK="$XDG_RUNTIME_DIR"/wob.sock

to_wob() {
  brightnessctl l | grep -oP '\d+(?=%)' > "$WOBSOCK"
}


case $1 in
  increase)
    brightnessctl s 5%+ && to_wob
    ;;
  decrease)
    brightnessctl s 5%- && to_wob
    ;;
  *)
    echo "$XDG_CONFIG_HOME/$0: The argument is not found."
esac
