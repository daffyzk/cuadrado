#! /bin/sh

# create personal nvim config
cat common/nvim/init.lua > personal/.config/nvim/init.lua
cat configs/nvim-personal.lua >> personal/.config/nvim/init.lua

# create personal alacritty config
cat common/alacritty/alacritty.toml > personal/.config/alacritty/alacritty.toml
cat configs/alacritty-personal.toml >> personal/.config/alacritty/alacritty.toml

# create personal wezterm config
cat common/wezterm/wezterm.lua > personal/.config/wezterm/wezterm.lua
# cat configs/wezterm-personal.lua >> personal/.config/wezterm/wezterm.lua

# stow personal
stow -vSt ~ --adopt personal
