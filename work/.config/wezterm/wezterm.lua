local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font_size = 16
config.font = wezterm.font('Comic Code')
config.enable_tab_bar = false

--- personal config
config.colors = {

    cursor_bg = '#ffffff',
    cursor_fg = '#000000',

    foreground = '#ffbafe',
    background = '#170717',

}

config.background = {
    {
        source = {
            File = '/home/user/repos/cuadrado/images/cute-baby-cats.jpg'
        },
        hsb = { brightness = 0.1 }
    }
}

return config
