#!/usr/bin/env nu

# Example: nu commands_menu.sh

def main [] {
  # sound
  let sound_script = ($env.FILE_PWD | path join "sound.nu")
  let sound_params = ["low-battery" "very-low-battery" "shutdown" "startup" "sleep" "default" "email-notify" "lock" "resume"]


  # wallpaper
  let wallpaper_script = ($env.FILE_PWD | path join "wallpaper.nu")
  let wallpaper_params = ["random" "next" "prev"]


  # color_picker
  let color_picker_script = ($env.FILE_PWD | path join "color_picker.nu")
  let color_picker_params = ["rgb" "hex"] # <-- Don't change this line
  

  # record_screen
  let record_screen_script = ($env.FILE_PWD | path join "record_screen.nu")
  let record_screen_params = ["start" "stop" "list"]


  # total scripts
  let sound_funcs = $sound_params | each { [" sound:" $in] | str join }
  let wallpaper_funcs = $wallpaper_params | each { [" wallpaper:" $in] | str join }
  let color_picker_funcs = $color_picker_params | each { [" color_picker:" $in] | str join }
  let record_screen_funcs = $record_screen_params | each { [" record_screen:" $in] | str join }


  # combine scripts && show them with `fuzzel -d`
  let list = $sound_funcs ++ $wallpaper_funcs ++ $color_picker_funcs ++ $record_screen_funcs
  let option = ($list | str join (char newline) | fuzzel -d)
  let infos = ($option | split column ":")
  let type = $infos | get "column1".0
  let arg = $infos | get "column2".0

  match $type {
    " sound" | "s" => { nu $sound_script --kind $arg }
    " wallpaper" | "w" => { nu $wallpaper_script $arg }
    " color_picker" | "c" => { nu $color_picker_script --format $arg }
    " record_screen" | "r" => { nu $record_screen_script $arg }
  }
}
