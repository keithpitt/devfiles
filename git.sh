#!/usr/bin/env devmachine

GIT_CONFIG_PATH="${GIT_CONFIG_PATH:-$HOME/.config/git}"

case "$1" in

  setup)
    os::install "git"
    devfile::run configure
    ;;

  configure)
    os::linkfile "git/config" "$GIT_CONFIG_PATH/config"
    os::linkfile "git/ignore" "$GIT_CONFIG_PATH/ignore"

    if [ ! -f "$GIT_CONFIG_PATH/user" ]; then
      echo "please run: devmachine git setuser"
      echo "please run: devmachine git setuser" > "$GIT_CONFIG_PATH/user"
    fi

    ;;

  edit-config)
    "$EDITOR" "$GIT_CONFIG_PATH/config"
    ;;

  edit-ignore)
    "$EDITOR" "$GIT_CONFIG_PATH/ignore"
    ;;

  setuser)
    read -r -p "full name: " name
    read -r -p "email: " email

    rm "$GIT_CONFIG_PATH/user"
    echo "[user]" >> "$GIT_CONFIG_PATH/user"
    echo "  email = $email" >> "$GIT_CONFIG_PATH/user"
    echo "  name = $name" >> "$GIT_CONFIG_PATH/user"

    echo "Saved to $GIT_CONFIG_PATH/user"
    cat "$GIT_CONFIG_PATH/user"
    ;;


  --is-installed)
    stdlib::test::is_command git && echo yes
    ;;

  --check-version)
    git --version | cut -d ' ' -f 3
    ;;

esac
