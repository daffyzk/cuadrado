
# term
set -Ux TERM "wezterm"

# setting new tempdir because it doesn't have enough space to build starknet-devnet lmao
set -Ux TMPDIR "/home/user/.tmp"

# aliases
alias ll="ls -a"
alias nivm="nvim"
alias v="nvim"
alias sl="sl -e"
alias jkb="pnpm build"
alias jks="pnpm start"
alias jki="pnpm install"
alias jku="pnpm update"

alias qubes-run-terminal="wezterm"
alias devnet100="starknet-devnet --seed 100 --accounts 1"

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
fish_add_path $HOME/.local/bin
fish_add_path -a $HOME/.foundry/bin
fish_add_path $HOME/.starkli/bin
fish_add_path /opt/google-cloud-cli/bin

# cool cairo config memes
set NVM_DIR "$HOME/.nvm"

# fish_add_path $HOME/.starkli/bin
# fish_add_path $HOME/.dojo/bin

# ASDF memes

if test -z $ASDF_DATA_DIR
	set _asdf_shims "$HOME/.asdf/shims"
else
	set _asdf_shims "$ASDF_DATA_DIR/shims"
end

if not contains $_asdf_shims $PATH
	set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

. /home/user/.starkli/env-fish


# noir and proving backend (bbup)

set NARGO_HOME "/home/user/.nargo"
fish_add_path $NARGO_HOME/bin
fish_add_path $HOME/.bb
set -gx PATH /home/user/.bb $PATH
