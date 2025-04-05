# plugin add ~/.cargo/bin/nu_plugin_dbus
# plugin add ~/.cargo/bin/nu_plugin_skim

use task.nu
use fuzzy.nu
source ~/.config/nushell/scripts/zoxide.nu

alias c = clear
alias y = yazi
alias e = explore
alias mpvl = mpv --loop
alias ll = ls -l
alias rm = rm --trash
alias co = cargo
alias gx = /var/guix/profiles/per-user/jedsek/current-guix/bin/guix
alias goto-config = cd ~/.config/nushell/
alias proxy_on = load-env { "http_proxy": "http://127.0.0.1:7890", "https_proxy": "http://127.0.0.1:7890" }
alias proxy_off = hide-env http_proxy https_proxy
proxy_on
def fetch [] {
  clear -k
  fastfetch
}
def --env load-bash-env [s: string] {
  mut s = ($s | str trim | lines | parse 'export {name}="{value}"' | transpose --header-row --as-record)

  if ("PWD" in ($s | columns)) {
    cd ($s | get "PWD")
    $s = ($s | reject "PWD")  
  }

  load-env $s
}

let fish_completer = {|spans|
    fish --command $'complete "--do-complete=($spans | str join " ")"'
    | from tsv --flexible --noheaders --no-infer
    | rename value description
}

$env.COMMAND_COUNT = 0
$env.config.history = {
  file_format: sqlite
}

$env.config = {
  show_banner: false
  edit_mode: emacs
  table: {
    mode: reinforced
  }

  hooks: {
    pre_prompt: [
      { $env.COMMAND_COUNT += 1 }
    ]
  }

    completions: {
      external: {
          enable: true
          completer: $fish_completer
      }
    }

  menus: [
    {
      name: ide_completion_menu
      only_buffer_difference: false
      marker: "| "
      type: {
          layout: ide
          min_completion_width: 0,
          max_completion_width: 70,
          max_completion_height: 30, # will be limited by the available lines in the terminal
          padding: 0,
          border: true,
          cursor_offset: 0,
          description_mode: "prefer_right"
          min_description_width: 0
          max_description_width: 50
          max_description_height: 10
          description_offset: 0
          correct_cursor_pos: true
      }
      style: {
          text: blue
          selected_text: { attr: r }
          description_text: green
          match_text: { attr: u }
          selected_match_text: { attr: ur }
      }
    }
    {
      name: skim_history_menu_fzf_ui
      only_buffer_difference: false
      marker: "# "
      type: {
          layout: columnar
          columns: 4
          col_width: 20
          col_padding: 2
      }
      style: {
          text: green
          selected_text: green_reverse
          description_text: yellow
      }
      source: { |buffer, position|
          open -r $nu.history-path | sk --tac | str trim
          | where $it =~ $buffer
          | each { |v| {value: ($v | str trim) } }
      }
    }
    {
        name: skim_menu_nu_ui
        only_buffer_difference: false
        marker: "# "
        type: {
            layout: list
            page_size: 10
        }
        style: {
            text: "#66ff66"
            selected_text: { fg: "#66ff66" attr: r }
            description_text: yellow
        }        
        source: { |buffer, position|
            open -r $nu.history-path
            | sk --regex --query $buffer
            | lines
            | each { |v| {value: ($v | str trim) } }
        }
    }
  ]
  
  keybindings: [
    {
      modifier: control
      keycode: space
      mode: [emacs, vi_normal, vi_insert]
      event: null
    }
    # {
    #   modifier: control
    #   keycode: char_l
    #   mode: [emacs, vi_normal, vi_insert]
    #   event: null
    # }
    {
      modifier: control
      keycode: char_f
      mode: [emacs, vi_normal, vi_insert]
      event: null
    }
    {
      name: ide_completion_menu
      modifier: alt
      keycode: space
      mode: [emacs vi_normal vi_insert]
      event: {
        until: [
            { send: menu name: ide_completion_menu }
            { send: menunext }
            { edit: complete }
        ]
      }
    }
    {
      name: change_dir_with_skim
      modifier: control
      keycode: char_f
      mode: emacs
      event: [
        { edit: clear }
        { edit: insertstring, value: "cd (fuzzy find_dir)" }
        { send: enter }
      ]
    }
  ]
}

# use '/home/jedsek/.config/broot/launcher/nushell/br' *
