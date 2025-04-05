#!/usr/bin/env -- nu

# Examples: nu wallpaper.nu <arg>
# 
# nu wallpaper.nu next
# nu wallpaper.nu prev
# nu wallpaper.nu random
# nu wallpaper.nu 0
# nu wallpaper.nu 1
# nu wallpaper.nu 2


def main [arg: string] {
  let wallpapers_dir = $env.FILE_PWD | path join "../assets/wallpapers"
  let len = (ls $wallpapers_dir | length)
  mut next_num = random int 0..<$len
  let timeout: duration = 1min
  
  match $arg {
    "scheduled_random" => {
      loop {
        switch $wallpapers_dir $next_num
        let $current_num = $next_num
        sleep $timeout
        while $next_num == $current_num { $next_num = random int 0..<$len }
      }
    }
    "scheduled_next" => {
      loop {
        switch $wallpapers_dir $next_num
        $next_num = ($next_num + 1) mod $len
        sleep $timeout
      }
    }
    "scheduled" => {
      let timeout: duration = 1min
      loop {
        switch $wallpapers_dir $next_num
        let $current_num = $next_num
        sleep $timeout
        while $next_num == $current_num { $next_num = random int 0..<$len }
      }
    }
    "random" => { while $next_num == (current_num) { $next_num = random int 0..<$len } }
    "next" => { $next_num = ((current_num) + 1) mod $len }
    "prev" => { $next_num = ((current_num) - 1) mod $len }
    "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" => { $next_num = $arg | into int }
    _ => { error make -u { msg: "Invalid arguments" } }
  }

  switch $wallpapers_dir $next_num
}

def query_swww [] {
  let path_info = (swww query | split column " " | get "column8".0 | path parse)

  ($path_info | get "parent")
  | append ($path_info | get "stem" | into int)
}

def switch [dir: string, num: int] {
  let wallpaper = ($dir | path join ([$num ".webp"] | str join))
  swww img $wallpaper --transition-step 255 --transition-fps 255 --transition-type wipe 
}

def current_num [] {
  let path_info = (swww query | split column " " | get "column8".0 | path parse)
  $path_info | get "stem" | into int
}
