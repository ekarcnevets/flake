{ pkgs, ... }: {
  # Deploy custom shell scripts to ~/.local/bin
  home.file.".local/bin/toggle-dark-mode.sh" = {
    source = ../files/scripts/toggle-dark-mode.sh;
    executable = true;
  };

  # Shell scripts packaged with runtime dependencies
  home.packages = [
    (pkgs.writeShellApplication {
      name = "defaults-to-nix";
      runtimeInputs = [ pkgs.gum pkgs.jq pkgs.python3 ];
      text = builtins.readFile ../files/defaults-to-nix.sh;
    })
  ];
}
