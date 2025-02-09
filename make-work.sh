#! /bin/sh

cat common/.config/nvim/init.lua > work/.config/nvim/init.lua
cat configs/nvim-work.lua >> work/.config/nvim/init.lua

cat common/.config/alacritty/alacritty.toml > work/.config/alacritty/alacritty.toml
cat configs/alacritty-work.toml >> work/.config/alacritty/alacritty.toml
