#!/usr/bin/env bash

# 这个文件记录了对应按键的 keycode:  
# /usr/include/linux/input-event-codes.h

export YDOTOOL_SOCKET=$HOME/.ydotool_socket

pos_x=$(hyprctl cursorpos | cut -d "," -f1)
pos_y=$(hyprctl cursorpos | cut -d "," -f2)

if [[ $1 == "click" ]]; then
  # absolute
  if [[ $2 == "--absolute" ]] || [[ $2 == "-a" ]]; then
    ydotool mousemove -a -x $3 -y $4
    ydotool click 0xc0
    # 鼠标点击之后记得回到之前的位置
    ydotool mousemove -a -x $pos_x -y $pos_y

  # relative
  elif [[ $2 == "--relative" ]] || [[ $2 == "-r" ]]; then
    ydotool mousemove -x $3 -y $4
    ydotool click 0xc0
    # 鼠标点击之后记得回到之前的位置
    ydotool mousemove -a -x $pos_x -y $pos_y

  # in-place
  # 如果没有给位置参数, 则鼠标在当前位置单击
  else
    ydotool click 0xc0
  fi

fi


if [[ $1 == "esc" ]]; then
  # Esc 的 keycode 是 1, 所以 `1:1` 表示 `按下` Esc,  `1:0` 表示 `松开` Esc  
  ydotool key 1:1 1:0
fi
