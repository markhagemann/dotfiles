{ config, lib, pkgs, osConfig ? null, ... }:

let
  cfg = config.modules.desktop.dms;
  jsonFormat = pkgs.formats.json { };
  settingsBase = import ./niri/settings-base.nix;
  
  # Try to get monitors from NixOS config (niri or mango), fallback to empty list
  monitors = if osConfig != null && osConfig.modules.desktop.niri.outputs != null then
               osConfig.modules.desktop.niri.outputs
             else if osConfig != null && osConfig.modules.desktop.mango.outputs != null then
               osConfig.modules.desktop.mango.outputs
             else
               [ ];

  # Create niriOutputSettings from monitors for settings.json
  niriOutputSettings =
    builtins.listToAttrs (
      map (o: {
        name = o.name;
        value = {
          hotCorners = {
            off = true;
          };
          layout = {
            alwaysCenterSingleColumn = true;
          };
        }
        // (lib.optionalAttrs (o.vrrOnDemand or false) { vrrOnDemand = true; });
      }) monitors
    )
    # Map VRR to the identifier (e.g. "DP-1") if specified
    // builtins.listToAttrs (
      map (o: {
        name = o.identifier;
        value = {
          vrrOnDemand = true;
        };
      }) (builtins.filter (o: (o.vrrOnDemand or false) && (o ? identifier)) monitors)
    );

  dmsSettings = lib.recursiveUpdate settingsBase {
    inherit niriOutputSettings;
    currentThemeName = "custom";
    currentThemeCategory = "generic";
    customThemeFile = "${config.home.homeDirectory}/.config/DankMaterialShell/themes/tokyonight-moon.json";
    matugenTemplateMangowc = true;
    barConfigs = [
      (
        (builtins.head settingsBase.barConfigs)
        // {
          screenPreferences = map (o: {
            model = o.name;
            name = o.identifier;
          }) monitors;
        }
      )
    ];
  };
in

{
  options.modules.desktop.dms = {
    enable = lib.mkEnableOption "Enable DMS home manager module";
    monitors = lib.mkOption {
      type = lib.types.listOf (lib.types.attrsOf lib.types.anything);
      default = [ ];
      description = "List of output configurations for DMS";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.quickshell.enable = true;

    home.packages = with pkgs; [
      matugen
      cliphist
      brightnessctl
      gammastep
      kdePackages.qtmultimedia
    ];

    home.file = {
      ".config/environment.d/20-qt-qml.conf".text = ''
        QML_IMPORT_PATH=${pkgs.kdePackages.qtmultimedia}/lib/qt-6/qml:${pkgs.kdePackages.qtsvg}/lib/qt-6/qml:${pkgs.kdePackages.qtimageformats}/lib/qt-6/qml:${pkgs.kdePackages.qt5compat}/lib/qt-6/qml
        QML2_IMPORT_PATH=${pkgs.kdePackages.qtmultimedia}/lib/qt-6/qml:${pkgs.kdePackages.qtsvg}/lib/qt-6/qml:${pkgs.kdePackages.qtimageformats}/lib/qt-6/qml:${pkgs.kdePackages.qt5compat}/lib/qt-6/qml
        QT_PLUGIN_PATH=${pkgs.kdePackages.qtimageformats}/lib/qt-6/plugins:${pkgs.kdePackages.qtsvg}/lib/qt-6/plugins:${pkgs.kdePackages.qtmultimedia}/lib/qt-6/plugins:${pkgs.kdePackages.qt5compat}/lib/qt-6/plugins
      '';

      ".config/DankMaterialShell/settings.json" = {
        source = jsonFormat.generate "settings.json" dmsSettings;
        force = true;
      };

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
            default-column-width { proportion 0.85; }
            default-window-height { proportion 0.85; }
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

      '';
      ".config/niri/dms/windowrules.kdl".force = true;
    };
  };
}
