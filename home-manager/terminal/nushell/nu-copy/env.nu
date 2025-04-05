# Nushell Environment Config File

# $env.PATH = ($env.PATH | prepend $"($env.HOME)/.cargo/bin")
# $env.PATH = ($env.PATH | prepend $"($env.HOME)/.moon/bin")
$env.PATH = ($env.PATH | prepend $"($env.HOME)/.local/bin")
$env.PATH = ($env.PATH | prepend $"($env.HOME)/.local/share/bin")
$env.PATH = ($env.PATH | prepend $"($env.HOME)/.nix-profile/bin")

$env.PATH = ($env.PATH | prepend $"($env.HOME)/.local/share/coursier/bin")

$env.JAVA_HOME = "/usr/lib/jvm/java-17-openjdk"

$env.KOTLIN_HOME = ($"($env.HOME)/.local/bin/kotlin/")
$env.PATH = ($env.PATH | prepend $"($env.KOTLIN_HOME)/kotlinc/bin")
$env.PATH = ($env.PATH | prepend $"($env.KOTLIN_HOME)/server/bin")

$env.HELIX_RUNTIME = "/usr/lib/helix/runtime"

# $env.GRADLE_HOME = ($"($env.HOME)/.local/bin/gradle/")
# $env.PATH = ($env.PATH | prepend $"($env.GRADLE_HOME)/gradle-8.2/bin/")


$env.YDOTOOL_SOCKET = ($"($env.HOME)/.ydotool_socket")


$env.PATH = ($env.PATH | prepend "/usr/racket/bin")

# $env.PATH = ($env.PATH | prepend $"($env.HOME)/.config/guix/current/bin")


$env.XDG_CONFIG_HOME = $"($env.HOME)/.config"
$env.XDG_CONFIG_HOME = "/home/jedsek/.config/"

$env.STARSHIP_SHELL = "nu"
$env.EDITOR = "helix"
$env.RUSTUP_UPDATE_ROOT = "https://mirrors.ustc.edu.cn/rust-static/rustup"
$env.RUSTUP_DIST_SERVER = "https://mirrors.ustc.edu.cn/rust-static"
$env._ZO_DATA_DIR = $"($nu.default-config-dir)"


$env.PROMPT_COMMAND = { || 
  let pwd = ($env.PWD | str replace $env.HOME "~")
  $"(ansi blue)($pwd)(ansi reset)" + "\n\n"
}

$env.PROMPT_COMMAND_RIGHT = { || 
  ""
}

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ": "
$env.PROMPT_INDICATOR_VI_NORMAL = "〉"
$env.PROMPT_MULTILINE_INDICATOR = "::: "

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
$env.NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
$env.NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
