#!/usr/bin/env devmachine

NVIM_CONFIG_PATH="${NVIM_CONFIG_PATH:-$HOME/.config/nvim}"

case "$1" in

  install)
    os::install "neovim"
    ;;

  lsps)
    os::sh npm install -g prettier

    os::install "shellcheck"
    os::sh npm i -g bash-language-server

    os::install "lua-language-server"

    os::sh npm install -g vim-language-server

    os::sh npm install -g typescript-language-server typescript
    os::sh npm install -g @astrojs/language-server
    os::install "prettierd"
    os::sh npm install -g prettier-plugin-astro
    os::sh npm install -g prettier-plugin-toml
    os::os npm install -g @tailwindcss/language-server

    os::sh gem install ruby-lsp

    os::sh go install golang.org/x/tools/gopls@latest

    os::sh npm install -g vscode-langservers-extracted
    ;;

  configure)
    os::linkfile "nvim/init.lua" "$NVIM_CONFIG_PATH/init.lua"
    os::linkfile "nvim/lua" "$NVIM_CONFIG_PATH/lua"
    ;;

  --is-installed)
    stdlib::test::is_command nvim && echo yes
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
