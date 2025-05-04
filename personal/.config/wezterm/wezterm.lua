local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font_size = 16
config.font = wezterm.font('Comic Code')
config.enable_tab_bar = false
config.warn_about_missing_glyphs = false
--- personal config
config.colors = {

    cursor_bg = '#ffffff',
    cursor_fg = '#000000',

    foreground = '#baffba',
    background = '#072707',

}

config.background = {
    {
        source = {
            File = '/home/user/repos/cuadrado/images/cute-cat-in-field.jpg'
        },
        hsb = { brightness = 0.05 }
    }
}

return config
