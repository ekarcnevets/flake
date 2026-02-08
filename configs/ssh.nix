{ ... }: {
  # 1Password SSH agent configuration
  home.file.".config/1Password/ssh/agent.toml".source = ../files/1password/agent.toml;
}
