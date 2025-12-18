#!/usr/bin/env devmachine

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃ ▄𜺣▗▖             ▗▖      ┃
# ┃ █𜴦𜷥▌𜷡𜶷𜷗▖𜷡𜴆𜶙▖▆ 𜶖𜵈 𜶙𜵈 ▆𜶠𜶨▖ ┃
# ┃ █ ▐▌𜶫▂𜷋𜴉𜶫▂𜷕𜴍𜴦𜶻𜵫▘ 𜷕𜷀 █𜴡▐▌ ┃
# ┃                          ┃
# ┃ https://neovim.io/       ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━┛

NVIM_CONFIG_PATH="${NVIM_CONFIG_PATH:-$HOME/.config/nvim}"

case "$1" in

install)
  os::install "neovim"
  ;;

upgrade)
  os::updatepackage "neovim"
  ;;

shellenv)
  old_vim_path="$(brew --prefix)/bin/vim"
  echo "
    alias _vim='$old_vim_path'
    alias vi='nvim'
    alias vim='nvim'
    alias view='nvim -R'
    alias vimdiff='nvim -d'
    alias e='nvim'
    export MANPAGER='nvim --cmd \"set termguicolors\" --cmd \"syntax on\" --cmd \"colorscheme retrobox\" --clean +Man!'
    "
  ;;

configure)
  os::linkfile "nvim" "$NVIM_CONFIG_PATH"
  ;;

--is-installed)
  stdlib_test command/exists nvim && echo yes
  ;;

esac
