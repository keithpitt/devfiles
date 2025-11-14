#!/usr/bin/env devmachine

case "$1" in

configure)
  os::linkfile "bin/download" "$HOME/.local/bin/download"
  os::linkfile "bin/figlet-with-preview" "$HOME/.local/bin/figlet-with-preview"
  os::linkfile "bin/ndiff" "$HOME/.local/bin/ndiff"
  ;;

shellenv)
  echo '
    export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
    export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
    export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
    export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
    export XDG_RUNTIME_DIR="/tmp/${UID}-runtime-dir"
    export XDG_BIN_HOME="${XDG_BINE_HOME:-$HOME/.local/bin}"
    export PATH="$XDG_BIN_HOME:$PATH"
    mkdir -p "${XDG_RUNTIME_DIR}"
    '
  ;;

--check-priority)
  echo 1000
  ;;

esac
