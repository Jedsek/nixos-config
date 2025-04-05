alias proxy_on = load-env { "http_proxy": "http://127.0.0.1:7890", "https_proxy": "http://127.0.0.1:7890" }
alias proxy_off = hide-env http_proxy https_proxy
proxy_on

alias hx = helix

def --env ya [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}


def ee [text: string] {
  echo $text | wl-copy
}

def post-rank-get [] {
  open ~/blog/source/_posts/post-rank.csv | sort-by rank -r
}

alias "post-rank-edit" = hx ~/blog/source/_posts/post-rank.csv

def kill-port [port: string] {
  let port = ':' + $port;
  let pid = (sudo netstat -nlp | grep $port | awk '{print $7}' | awk -F "/" '{ print $1 }')
  kill -9 ($pid | into int)
}

alias ll = ls -l
alias c = clear
alias e = exa
alias el = exa -lhHbig
alias xp = xplr
alias mkd = mkdir
alias mkf = touch


alias upgrade = sudo dnf upgrade
alias install = sudo dnf install
alias remove  = sudo dnf remove
alias copr    = dnf copr
alias search  = dnf search
alias info    = dnf info


alias co   =  cargo
alias si   =  swift
alias sc   =  scala
alias scc  =  scalac
alias ja   =  java
alias jac  =  javac
alias jap  =  javap

alias wez  = wezterm
alias img  = wezterm imgcat
alias n    = nnn


alias clone   = git clone --depth 1
alias remote  = git remote
alias add     = git add --all
alias commit  = git commit -m
alias push    = git push


alias "bluec" = bluetoothctl connect 0C:AE:BD:D7:C3:E4
alias "blued" = bluetoothctl disconnect

alias "idr"  = rlwrap idris2
alias "idr r" = idris2 -x main 


alias rkt = racket

alias chrome = google-chrome-unstable



alias pa = paru

alias zr  = zellij run -- 
alias zrf = zellij run -f -- 
alias ze  = zellij edit
alias zef = zellij edit -f

alias shutdown = bash -c "sh ~/.config/hypr/scripts/sound.sh --shutdown && shutdown now"
alias reboot = bash -c "sh ~/.config/hypr/scripts/sound.sh --shutdown && reboot"
alias wallpaper_next = bash -c 'echo "no-audio" > $XDG_RUNTIME_DIR/wallpaper.sock'


def --wrapped fetch [...args] {
  clear;
  fastfetch ...$args
}

alias edge = microsoft-edge-dev -enable-features=UseOzonePlatform --ozone-platform=wayland
