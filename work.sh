#! /bin/sh

# make nvim work config
cat shared/nvim/init.lua > work/.config/nvim/init.lua
cat configs/nvim-work.lua >> work/.config/nvim/init.lua

# make alacritty work config
cat shared/alacritty/alacritty.toml > work/.config/alacritty/alacritty.toml
cat configs/alacritty-work.toml >> work/.config/alacritty/alacritty.toml

# create personal wezterm config
cat shared/wezterm/wezterm.lua > work/.config/wezterm/wezterm.lua
cat configs/wezterm-work.lua >> work/.config/wezterm/wezterm.lua

# stow work dotfiles
stow -vSt ~ --adopt work

