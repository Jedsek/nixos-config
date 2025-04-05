#!/usr/bin/env bash

count=""
wallpaper=""

wallpaper_sock=$XDG_RUNTIME_DIR/wallpaper.sock
wallpaper_dir=~/Videos
wallpaper_number=$(ls -l $wallpaper_dir | grep "^-" | wc -l)

if [[ $1 == "--startup" ]];
then
  rm -f $wallpaper_sock && mkfifo $wallpaper_sock
  random=`expr $RANDOM % $wallpaper_number`
  startup_random_wallpaper=$wallpaper_dir/wallpaper-$random.mp4
  killall -9 mpvpaper
  mpvpaper -o "--no-audio --loop-playlist" '*' $startup_random_wallpaper &
else
  while true;do
    args=$(cat $wallpaper_sock)
    count=`expr $count + 1`
    count=`expr $count % $wallpaper_number`
    killall -9 mpvpaper
    mpvpaper -o "--no-audio --loop-playlist" '*' "$wallpaper_dir/wallpaper-$count.mp4" &
    sleep 0.1s
  done
fi
