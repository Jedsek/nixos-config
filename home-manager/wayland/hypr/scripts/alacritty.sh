#!/usr/bin/env bash

if [[ -z $(pidof alacritty) ]]; then
  alacritty --daemon
else
  alacritty msg create-window
fi
