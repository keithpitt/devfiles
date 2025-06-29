#!/usr/bin/env devmachine

VIM_CONFIG_PATH="${VIM_CONFIG_PATH:-$HOME/.config/vim}"

case "$1" in

logo)
  devicon "vim"
  ;;

setup)
  @run install
  @run configure
  @run reload-plugins
  ;;

install)
  os::install "vim"
  ;;

configure)
  os::softdelete "~/.vimrc"
  os::softdelete "~/.vim"
  os::linkfile "vim/autoload/plug.vim" "$VIM_CONFIG_PATH/autoload/plug.vim"
  os::linkfile "vim/vimrc" "$VIM_CONFIG_PATH/vimrc"
  os::linkfile "vim/vimrc-netrw" "$VIM_CONFIG_PATH/vimrc-netrw"
  @run reload-plugins
  ;;

reload-plugins)
  vim +PlugInstall +qall
  ;;

edit-config)
  "$EDITOR" "$VIM_CONFIG_PATH/vimrc"
  @run reload-plugins
  ;;

# shellenv)
#   echo 'export EDITOR="vim"'
#   ;;

--is-installed)
  stdlib::test::is_command vim && echo yes
  ;;

esac
