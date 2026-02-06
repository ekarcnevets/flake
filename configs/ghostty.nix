{ ... }: {
  # Ghostty configuration
  home.file.".config/ghostty/config".source = ../files/ghostty/config;

  # Ghostty cursor shader
  home.file.".config/ghostty/shaders/cursor_smear_fade.glsl".source = ../files/ghostty/shaders/cursor_smear_fade.glsl;
}
