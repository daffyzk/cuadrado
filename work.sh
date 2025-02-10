#! /bin/sh

# make nvim work config
cat shared/nvim/init.lua > work/.config/nvim/init.lua
cat configs/nvim-work.lua >> work/.config/nvim/init.lua

# make alacritty work config
cat shared/alacritty/alacritty.toml > work/.config/alacritty/alacritty.toml
cat configs/alacritty-work.toml >> work/.config/alacritty/alacritty.toml

# stow work dotfiles
stow -vSt ~ --adopt work

