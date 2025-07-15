#!/usr/bin/env devmachine

FIGLET_CONFIG_PATH="${FIGLET_CONFIG_PATH:-$XDG_CONFIG_HOME/figlet}"

case "$1" in

setup)
  os::install "figlet"
  ;;

configure)
  os::linkfile "figlet" "$FIGLET_CONFIG_PATH"
  ;;

download-fonts)
  shopt -s extglob nullglob globskipdots

  TEMP="$(mktemp -d)"
  cd "$TEMP"
  git clone "https://github.com/xero/figlet-fonts.git"
  cd "figlet-fonts"
  mv *.flf ~/Code/devfiles/figlet/fonts/ || true
  mv *.flc ~/Code/devfiles/figlet/fonts/ || true

  TEMP="$(mktemp -d)"
  cd "$TEMP"
  git clone "https://github.com/PhMajerus/FIGfonts"
  cd "FIGfonts"
  cd "fonts"
  ls
  mv *.flf ~/Code/devfiles/figlet/fonts/ || true
  mv *.flc ~/Code/devfiles/figlet/fonts/ || true
  ;;

shellenv)
  echo "export FIGLET_FONTDIR=\"$FIGLET_CONFIG_PATH/fonts\""
  ;;

--is-installed)
  stdlib_test command/exists figlet && echo yes
  ;;

esac
