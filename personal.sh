#! /bin/sh

# create personal nvim config
cat common/.config/nvim/init.lua > personal/.config/nvim/init.lua
cat configs/nvim-personal.lua >> personal/.config/nvim/init.lua

# create personal alacritty config
cat common/.config/alacritty/alacritty.toml > personal/.config/alacritty/alacritty.toml
cat configs/alacritty-personal.toml >> personal/.config/alacritty/alacritty.toml

# stow personal

stow -vSt ~ --adopt personal
