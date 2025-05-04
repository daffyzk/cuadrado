local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font_size = 16
config.font = wezterm.font('Comic Code')
config.enable_tab_bar = false
config.warn_about_missing_glyphs = false
config.disable_default_key_bindings = true
