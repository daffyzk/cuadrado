#! /bin/sh

# create personal nvim config
cat shared/nvim/init.lua > personal/.config/nvim/init.lua
cat configs/nvim-personal.lua >> personal/.config/nvim/init.lua

#copy nvim themes
cp -r shared/nvim/colors personal/.config/nvim

# create personal alacritty config
cat shared/alacritty/alacritty.toml > personal/.config/alacritty/alacritty.toml
cat configs/alacritty-personal.toml >> personal/.config/alacritty/alacritty.toml

# create personal wezterm config
cat shared/wezterm/wezterm.lua > personal/.config/wezterm/wezterm.lua
cat configs/wezterm-personal.lua >> personal/.config/wezterm/wezterm.lua

# stow personal
stow -vSt ~ --adopt personal
