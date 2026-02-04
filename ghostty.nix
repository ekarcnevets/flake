{ ... }: {
  # Ghostty configuration
  home.file.".config/ghostty/config".text = ''
    # Font
    font-family = "GoMono Nerd Font"
    font-size = 14

    # Display
    theme = light:Atom One Light,dark:Atom
    custom-shader = ./shaders/cursor_smear_fade.glsl

    # Cursor
    cursor-style = block
    cursor-style-blink = false
    cursor-click-to-move = true
    shell-integration-features = no-cursor

    # Window
    window-inherit-working-directory = true
    window-inherit-font-size = true
    window-theme = system

    # Keybinds
    keybind = super+shift+f=write_screen_file:open
    keybind = shift+enter=text:\n
    macos-option-as-alt = right

    # Misc
    clipboard-trim-trailing-spaces = true
  '';

  # Ghostty cursor shader
  home.file.".config/ghostty/shaders/cursor_smear_fade.glsl".source = ./dotfiles/ghostty/shaders/cursor_smear_fade.glsl;
}
