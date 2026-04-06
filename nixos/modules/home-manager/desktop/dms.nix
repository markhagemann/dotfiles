{ pkgs, ... }:

{
  programs.quickshell.enable = true;

  # DMS deps - required by NixOS module's dms-shell config
  home.packages = with pkgs; [
    matugen
    cliphist
    brightnessctl
    gammastep
    kdePackages.qtmultimedia
  ];

  # Environment - Qt paths (need pkgs)
  home.file = {
    ".config/environment.d/20-qt-qml.conf".text = ''
      QML_IMPORT_PATH=${pkgs.kdePackages.qtmultimedia}/lib/qt-6/qml:${pkgs.kdePackages.qtsvg}/lib/qt-6/qml:${pkgs.kdePackages.qtimageformats}/lib/qt-6/qml:${pkgs.kdePackages.qt5compat}/lib/qt-6/qml
      QML2_IMPORT_PATH=${pkgs.kdePackages.qtmultimedia}/lib/qt-6/qml:${pkgs.kdePackages.qtsvg}/lib/qt-6/qml:${pkgs.kdePackages.qtimageformats}/lib/qt-6/qml:${pkgs.kdePackages.qt5compat}/lib/qt-6/qml
      QT_PLUGIN_PATH=${pkgs.kdePackages.qtimageformats}/lib/qt-6/plugins:${pkgs.kdePackages.qtsvg}/lib/qt-6/plugins:${pkgs.kdePackages.qtmultimedia}/lib/qt-6/plugins:${pkgs.kdePackages.qt5compat}/lib/qt-6/plugins
    '';

    "tokyonight-moon.json".source = ./niri/themes/tokyonight-moon.json;
    ".local/share/dms/avatar.jpg".source = ../../../assets/avatar.jpg;
    ".config/DankMaterialShell/themes/tokyonight-moon.json".source = ./niri/themes/tokyonight-moon.json;

    ".config/niri/dms/windowrules.kdl".text = ''

      window-rule {
          match app-id=r#".*$"#
          variable-refresh-rate false
          open-floating true
      }

      window-rule {
          match app-id=r#"^faugus.*$"#
          open-on-workspace "gaming"
      }

      window-rule {
          match title="Diablo II"
          open-fullscreen true
          variable-refresh-rate true
      }

      window-rule {
          match title="World of Warcraft"
          open-fullscreen true
          variable-refresh-rate true
      }

      window-rule {
          match app-id="mpv"
          match app-id="dolphin"
          match app-id="steam"
          match app-id="spotify"
          match title=r#"^(Battle\.net.*)$"#
          default-column-width { proportion 0.5; }
          default-window-height { proportion 0.75; }
      }

      window-rule {
          match app-id="dolphin"
          match app-id="discord"
          match app-id="spotify"
          opacity 0.97
      }

      window-rule {
          match app-id="kitty"
          default-column-width { proportion 0.85; }
          default-window-height { proportion 0.85; }
          open-on-workspace "terminal"
      }

      window-rule {
          match app-id="steam"
          open-on-workspace "gaming"
      }

      window-rule {
          match app-id="spotify"
          open-on-workspace "spotify"
      }

      // non-floating windows must come last
      window-rule {
          match app-id="firefox"
          open-on-workspace "browser"
          open-floating false
      }

      window-rule {
          match app-id="discord"
          open-on-workspace "discord"
          open-floating false
      }
    '';
    ".config/niri/dms/windowrules.kdl".force = true;
  };
}
