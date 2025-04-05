#!/usr/bin/env nu

def main [
  --format: string (-f)
  --copy (-c)
] {
  let background_color = "#ffffff10"
  let pos_region = slurp -b $background_color -p
  let temp_file = mktemp --suffix ".png"

  grim -g $pos_region -t "png" $temp_file

  let arg = match $format {
    "hex" => "#%[hex:p{0,0}]"
    "rgb" => "rgb(%[fx:int(255*r)], %[fx:int(255*g)], %[fx:int(255*b)])"
    _     => { error make -u { msg: "The format is not supported" } }
  }
  
  let output = magick $temp_file -format $arg "info:"
  rm $temp_file
  
  notify-send " color-picker:" $output
}
