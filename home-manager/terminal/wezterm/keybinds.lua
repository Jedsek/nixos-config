local wezterm = require 'wezterm'
local keybinds = {}
local act = wezterm.action

keybinds.keys = {
  {
    key = '5',
    mods = 'CTRL | ALT',
    action = act.SplitHorizontal{ domain = "CurrentPaneDomain" },
  },

  {
    key = 'Enter',
    mods = 'ALT',
    action = act.Nop,
  },

  {
    key = '4',
    mods = 'CTRL | ALT',
    action = act.SplitVertical{ domain = "CurrentPaneDomain" },
  },

  {
    key = 'z',
    mods = 'CTRL | ALT',
    action = act.TogglePaneZoomState,
  },

  {
    key = 'd',
    mods = 'CTRL | ALT',
    action = act.CloseCurrentPane{ confirm = false },
  },
  { 
    key = 's', 
    mods = 'CTRL | ALT', 
    action = act.Multiple {
      act.SetPaneZoomState(false),
      act.PaneSelect, 
    }
  },
}
return keybinds
