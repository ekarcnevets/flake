{ ... }: {
  home.file.".ssh/config".source = ./ssh-config;
  home.file.".ssh/allowed_signers".source = ./allowed-signers;
}
