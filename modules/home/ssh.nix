{ ... }: {
  # SSH allowed signers for signature verification
  home.file.".ssh/allowed_signers".source = ../../dotfiles/ssh/allowed_signers;

  # SSH configuration for 1Password
  home.file.".ssh/config".source = ../../dotfiles/ssh/config;

  # 1Password SSH agent configuration
  home.file.".config/1Password/ssh/agent.toml".source = ../../dotfiles/1password/agent.toml;
}
