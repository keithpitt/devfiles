#!/usr/bin/env devmachine

case "$1" in

  configure)
    os::linkfile "bin/download" "$HOME/.local/bin/download"
    ;;

  shellenv)
    echo '
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_CACHE_HOME="$HOME/.cache"
    export XDG_DATA_HOME="$HOME/.local/share"
    export XDG_STATE_HOME="$HOME/.local/state"
    export XDG_RUNTIME_DIR="/run/user/$UID"
    export XDG_BIN_HOME="$HOME/.local/bin"
    export PATH="$XDG_BIN_HOME:$PATH"
    '
    ;;

  --check-priority)
    echo 1000
    ;;

esac
