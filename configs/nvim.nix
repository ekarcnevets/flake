{ pkgs, lib, ... }: {
  # Install neovim
  home.packages = with pkgs; [
    neovim
  ];

  # Symlink NvChad configuration
  xdg.configFile."nvim" = {
    source = ../files/nvim;
    recursive = true;
  };

  # Replace lazy-lock.json symlink with a writable copy
  # This allows Lazy.nvim to update the lockfile while keeping it in version control
  home.activation.copyLazyLock = lib.hm.dag.entryAfter ["writeBoundary"] ''
    LOCK_FILE="$HOME/.config/nvim/lazy-lock.json"
    if [ -L "$LOCK_FILE" ]; then
      $DRY_RUN_CMD rm "$LOCK_FILE"
      $DRY_RUN_CMD cp ${../files/nvim/lazy-lock.json} "$LOCK_FILE"
      $DRY_RUN_CMD chmod u+w "$LOCK_FILE"
    fi
  '';
}
