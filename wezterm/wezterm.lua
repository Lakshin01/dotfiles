local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}

config.font = wezterm.font 'JetBrains Mono'
config.color_scheme = 'Lab fox'
config.window_background_opacity = 0.69
config.font_size = 18

config.keys = {
  {
    key = "v",
    mods = "CTRL|ALT",
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "h",
    mods = "CTRL|ALT",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
}

return config

