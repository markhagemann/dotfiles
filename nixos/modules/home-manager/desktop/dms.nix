{ inputs, pkgs, ... }:

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
    ".local/share/dms/avatar.jpg".source = ./niri/avatar.jpg;
    ".config/DankMaterialShell/themes/tokyonight-moon.json".source = ./niri/themes/tokyonight-moon.json;

    ".config/niri/dms/windowrules.kdl".text = ''

      window-rule {
          match app-id=r#".*"#
          open-floating true
      }

      window-rule {
          match app-id=r#"^faugus.*$"#
          open-on-workspace "gaming"
      }

      window-rule {
           match title="Diablo II"
           variable-refresh-rate true
      }

      window-rule {
          match app-id="dolphin"
          opacity 0.97
      }

      window-rule {
          match app-id="kitty"
          opacity 0.97
          open-on-workspace "terminal"
      }

      window-rule {
          match app-id="steam"
          open-on-workspace "gaming"
      }

      window-rule {
          match app-id="firefox"
          open-floating false
          open-on-workspace "browser"
      }

      window-rule {
          match app-id="discord"
          opacity 0.97
          open-floating false
          open-on-workspace "discord"
      }

      window-rule {
          match app-id="spotify"
          opacity 0.97
          open-floating false
          open-on-workspace "spotify"
      }

    '';
    ".config/niri/dms/windowrules.kdl".force = true;
  };
}
