local wezterm = require 'wezterm'
local config = {}
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 12
config.window_decorations = "NONE"
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = 'NeverPrompt'
local act = wezterm.action
config.keys = {
  { key = 'K',         mods = 'SHIFT|CTRL', action = act.ScrollByLine(-3) },
  { key = 'J',         mods = 'SHIFT|CTRL', action = act.ScrollByLine(3) },
  { key = 'UpArrow',   mods = 'SHIFT|CTRL', action = act.ScrollByLine(-10) },
  { key = 'DownArrow', mods = 'SHIFT|CTRL', action = act.ScrollByLine(10) },
}
return config
