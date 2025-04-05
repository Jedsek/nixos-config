if "ALACRITTY_SOCKET" not-in $env {
  task spawn -i {alacritty --daemon}
} else {
  alacritty msg create-window
}
