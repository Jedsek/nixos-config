#!/usr/bin/env -- nu

def main [arg: string] {
  match $arg {
    "start" => {
      notify-send " wf-recorder:" "starting"
      let path = (mktemp -p ~/Videos/ --suffix ".mp4")
      wf-recorder -f $path
    }
    "stop" => {
      notify-send " wf-recorder:" "stopping"
      pkill --signal SIGINT wf-recorder
    }
    "list" => {
      let video = (ls ~/Videos/ | sort-by modified -r | get name | str join (char newline) | fuzzel -d)
      mpv --loop $video
    }
  }
}
