#!/usr/bin/env bash

rgb=$(hyprpicker -a -f rgb)

hex="#"
for x in $rgb
do
  hex=$hex$(printf %x $x)
done


echo $hex

if [ -n "${rgb}" ]; then
  notify-send "color-picker:" "hex-> $hex\nrgb-> $rgb"
fi

