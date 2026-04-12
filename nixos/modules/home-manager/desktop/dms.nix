{
  inputs,
  config,
  lib,
  pkgs,
  osConfig ? null,
  ...
}:

let
  cfg = config.modules.desktop.dms;
  jsonFormat = pkgs.formats.json { };
  settingsBase = import ./niri/settings-base.nix;

  # Try to get monitors from NixOS config (niri or mango), fallback to empty list
  monitors =
    if osConfig != null && osConfig.modules.desktop.niri.outputs != null then
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
    barConfigs = [
      (
        (builtins.head settingsBase.barConfigs)
        // {
          screenPreferences = map (o: {
            model = o.name;
            name = o.identifier;
          }) (builtins.filter (o: o.bar or false) monitors);
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

    systemd.user.services.dms = {
      Unit = {
        Description = "Dank Material Shell (DMS)";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "dbus";
        BusName = "org.freedesktop.Notifications";
        ExecStartPre = "${pkgs.bash}/bin/bash -c 'if [ \"$XDG_CURRENT_DESKTOP\" = \"KDE\" ]; then exit 1; fi; until [ -S \"$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY\" ]; do sleep 0.5; done'";
        ExecStart = "${
          inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default
        }/bin/dms run --session";
        Restart = "on-failure";
        RestartSec = 1;
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    home.packages = with pkgs; [
      matugen
      cliphist
      brightnessctl
      gammastep
      kdePackages.qtmultimedia
    ];

    home.file = lib.mkIf cfg.enable {
      ".local/bin/mic-ptt" = {
        text = ''
          #!/usr/bin/env bash
          STATE_FILE="$HOME/.mic-ptt-state"

          case "$1" in
              press)
                  wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0
                  echo "unmuted" > "$STATE_FILE"
                  ;;
              release)
                  if [[ -f "$STATE_FILE" ]]; then
                      wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1
                      rm -f "$STATE_FILE"
                  fi
                  ;;
          esac
        '';
        executable = true;
      };

      ".local/bin/raise-cycle-or-spawn" = {
        source = ./scripts/raise-cycle-or-spawn.sh;
        executable = true;
      };

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
    };
  };
}
