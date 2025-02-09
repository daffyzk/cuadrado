#! /bin/sh

cat common/.config/nvim/init.lua > personal/.config/nvim/init.lua
cat configs/nvim-personal.lua >> personal/.config/nvim/init.lua

cat common/.config/alacritty/alacritty.toml > personal/.config/alacritty/alacritty.toml
cat configs/alacritty-personal.toml >> personal/.config/alacritty/alacritty.toml
