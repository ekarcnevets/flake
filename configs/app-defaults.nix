{ ... }: {
  # Managed by defaults-to-nix and /sync-defaults command

  # Shottr screenshot tool
  targets.darwin.defaults."cc.ffitch.shottr" = {
    KeyboardShortcuts_area = "{\"carbonModifiers\":768,\"carbonKeyCode\":19}";
    KeyboardShortcuts_fullscreen = "{\"carbonModifiers\":768,\"carbonKeyCode\":18}";
    KeyboardShortcuts_ocr = "{\"carbonModifiers\":6400,\"carbonKeyCode\":31}";
    KeyboardShortcuts_reopen = "{\"carbonKeyCode\":29,\"carbonModifiers\":768}";
    KeyboardShortcuts_scrolling = "{\"carbonKeyCode\":21,\"carbonModifiers\":768}";
    KeyboardShortcuts_window = "{\"carbonModifiers\":768,\"carbonKeyCode\":20}";
    afterGrabCopy = true;
    afterGrabSave = false;
    afterGrabShow = false;
    allowTelemetry = false;
    areaCaptureMode = "preview";
    copyOnEsc = true;
  };
}
