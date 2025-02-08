
# aliases
alias ll="ls -a"
alias nivm="nvim"
alias v="nvim"
alias sl="sl -e"

# colors
set -x GIT_CONFIG_COUNT 3
set -x GIT_CONFIG_KEY_0 "color.branch.current"
set -x GIT_CONFIG_VALUE_0 "#00cc8b"
set -x GIT_CONFIG_KEY_1 "color.status.changed"
set -x GIT_CONFIG_VALUE_1 "#ff87d9"
set -x GIT_CONFIG_KEY_2 "color.status.untracked"
set -x GIT_CONFIG_VALUE_2 "#ff0044"

set -Ux LS_COLORS "di=38;2;0;204;139:ex=38;2;251;0;255:ln=38;2;0;204;255:ow=48;2;255;255;255;38;2;0;0;204"

set -g fish_color_normal "#ff87d9"

# env variables
fish_add_path $HOME/go/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/share/solana/install/active_release/bin


# cool cairo config memes
fish_add_path $HOME/.dojo/bin

source ~/.asdf/asdf.fish
. "$HOME/.starkli/env-fish"

fish_add_path $HOME/.local/bin
