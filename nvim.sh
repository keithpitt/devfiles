#!/usr/bin/env devmachine

NVIM_CONFIG_PATH="${NVIM_CONFIG_PATH:-$HOME/.config/nvim}"

case "$1" in

  install)
    os::install "neovim"
    ;;

  lsps)
    os::install "shellcheck"
    os::sh npm i -g bash-language-server

    os::install "lua-language-server"

    os::sh npm install -g vim-language-server

    os::sh gem install ruby-lsp
    ;;

  configure)
    os::linkfile "nvim/init.lua" "$NVIM_CONFIG_PATH/init.lua"
    os::linkfile "nvim/lua" "$NVIM_CONFIG_PATH/lua"
    ;;

  --is-installed)
    stdlib::test::is_command nvim && echo yes
    ;;

  shellenv)
    echo 'export EDITOR="nvim"'
    echo "alias v='nvim'"
    ;;

  # --check-version)
  #   # This feels like it could be easier...
  #   vim --version |
  #     head -n 1 |
  #     sed -r 's:[^0-9\. ]*::g' |
  #     tr -s ' ' |
  #     cut -d ' ' -f 2
  #   ;;

esac
