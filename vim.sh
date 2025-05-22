#!/usr/bin/env devmachine

VIM_CONFIG_PATH="${VIM_CONFIG_PATH:-$HOME/.config/vim}"

case "$1" in

  logo)
    devicon "vim"
    ;;

  setup)
    devfile::run install
    devfile::run configure
    devfile::run reload-plugins
    ;;

  install)
    os::install "vim"
    os::download "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" \
      "$VIM_CONFIG_PATH/autoload/plug.vim"
    ;;

  configure)
    os::softdelete "$HOME/.vimrc"
    os::softdelete "$HOME/.vim"
    os::linkfile "$DEVFILES_PATH/vim/vimrc" "$VIM_CONFIG_PATH/vimrc"
    os::linkfile "$DEVFILES_PATH/vim/vimrc-netrw" "$VIM_CONFIG_PATH/vimrc-netrw"
    ;;

  reload-plugins)
    vim +PlugInstall +qall
    ;;

  edit-config)
    "$EDITOR" "$VIM_CONFIG_PATH/vimrc"
    devfile::run reload-plugins
    ;;

  shellenv)
    echo 'export EDITOR="vim"'
    ;;

  --check-installed)
    command -v vim &> /dev/null && echo yes
    ;;

  --check-version)
    # This feels like it could be easier...
    vim --version |
      head -n 1 |
      sed -r 's:[^0-9\. ]*::g' |
      tr -s ' ' |
      cut -d ' ' -f 2
    ;;

esac
