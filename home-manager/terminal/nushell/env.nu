$env.RUSTUP_DIST_SERVER = "https://rsproxy.cn"
$env.RUSTUP_UPDATE_ROOT = "https://rsproxy.cn/rustup"

$env.GUIX_PROFILE = "/var/guix/profiles/per-user/jedsek/current-guix"

$env.PATH = (
  $env.PATH
  | split row (char esep)
  | append ~/.cargo/bin
  | append ~/.opam/default/bin
  # | append $"($env.GUIX_PROFILE)/bin"
  | append [/usr/local/bin ~/.local/bin ~/.local/share/bin]
  | uniq # filter so the paths are unique
)

$env.OPAM_LAST_ENV = "/home/jedsek/.opam/.last-env/env-a681044e763b34e12b9fd24f446d77a8-0"
$env.OPAM_SWITCH_PREFIX = "/home/jedsek/.opam/default"
$env.OCAMLTOP_INCLUDE_PATH = "/home/jedsek/.opam/default/lib/toplevel:~/.opam/default/lib/toplevel"
$env.CAML_LD_LIBRARY_PATH = "/home/jedsek/.opam/default/lib/stublibs:/home/jedsek/.opam/default/lib/ocaml/stublibs:/home/jedsek/.opam/default/lib/ocaml"
$env.OCAML_TOPLEVEL_PATH = "/home/jedsek/.opam/default/lib/toplevel"
$env.MANPATH = ":~/.opam/default/man:/home/jedsek/.opam/default/man"
# $env.PATH = "/home/jedsek/.opam/default/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/bin:~/.cargo/bin:/var/guix/profiles/per-user/jedsek/current-guix/bin:~/.local/bin:~/.local/share/bin:~/.opam/default/bin"

$env.EDITOR = "hx"

$env.TRANSIENT_PROMPT_INDICATOR = ">> "
$env.TRANSIENT_PROMPT_COMMAND = ""
$env.TRANSIENT_PROMPT_COMMAND_RIGHT = ""

$env.PROMPT_COMMAND_RIGHT = ""
$env.PROMPT_INDICATOR = ">> "
$env.PROMPT_INDICATOR_VI_NORMAL = (color {fg: black, bg: blue} "NOR>") + " "
$env.PROMPT_INDICATOR_VI_INSERT = (color {fg: black, bg: green} "INS>") + " "
$env.PROMPT_COMMAND = {||
  let newline = "\n\r"
  let separator = " "

  let count = $env.COMMAND_COUNT
  let count = color light_red_bold $"[($count)]"
  
  let date = date now | format date "%H-%M-%S"
  let date = color light_green_bold $"[($date)]"

  # let pwd = ($env.PWD | str replace $env.HOME "~")
  let pwd = ($env.PWD)
  let pwd = color {fg: blue, attr: bu} $pwd
  
  ([$pwd, $date, $count] | str join $separator) + $newline
}

def color [style, content] {
  $"(ansi $style)($content)(ansi reset)"
}
