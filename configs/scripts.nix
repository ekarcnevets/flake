{ ... }: {
  # Deploy custom shell scripts to ~/.local/bin
  home.file.".local/bin/toggle-dark-mode.sh" = {
    source = ../files/scripts/toggle-dark-mode.sh;
    executable = true;
  };
}
