{ host, ... }: ''
  // Work around WezTerm's initial configure bug
  window-rule {
      match app-id=r#"^org\.wezfurlong\.wezterm$"#
      default-column-width {}
  }

  // Open the Firefox picture-in-picture player as floating by default
  window-rule {
      match app-id=r#"firefox$"# title="^Picture-in-Picture$"
      open-floating true
  }

  // Global window styling
  window-rule {
      geometry-corner-radius 9
      clip-to-geometry true
      draw-border-with-background false
  }

  // Opacity rules for specific applications
  window-rule {
      match app-id=r#"^(kitty|dolphin)$"#
      opacity 0.95
  }

  // Firefox, Zen and LibreWolf settings
  window-rule {
      match app-id=r#"^(zen-beta|dev\.firefox\.librewolf)$"#
      opacity 0.98
      default-column-width { proportion 0.75; }
  }

  // Steam opacity
  window-rule {
      match app-id=r#"^(steam)$"#
      opacity 0.97
  }
''
