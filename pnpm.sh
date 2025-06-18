#!/usr/bin/env devmachine

PNPM_CONFIG_PATH="${PNPM_CONFIG_PATH:-$HOME/.config/pnpm}"

case "$1" in

  install)
    curl -fsSL https://get.pnpm.io/install.sh | sh -

    if ! grep "# pnpm" ~/.zshrc; then
      echo "markers weren't added, dunno how to continue"
      exit
    fi

    sed -n "/# pnpm/,/# pnpm end/p" ~/.zshrc > "$DEVFILES_PATH/pnpm/shellenv"
    sed -i '' '/# pnpm/,/# pnpm end/d' ~/.zshrc

    @run configure
    ;;

  configure)
    os::linkfile "pnpm/rc" "$PNPM_CONFIG_PATH/rc"
    ;;

  shellenv)
    cat "pnpm/shellenv"
    ;;

  --is-installed)
    stdlib::test::is_command pnpm && echo yes
    ;;

  --check-version)
    pnpm --version
    ;;

esac
