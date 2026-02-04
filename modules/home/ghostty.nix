{ ... }: {
  # Ghostty configuration
  home.file.".config/ghostty/config".source = ../../dotfiles/ghostty/config;

  # Ghostty cursor shader
  home.file.".config/ghostty/shaders/cursor_smear_fade.glsl".source = ../../dotfiles/ghostty/shaders/cursor_smear_fade.glsl;
}
