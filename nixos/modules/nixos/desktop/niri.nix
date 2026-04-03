{
  options,
  config,
  lib,
  pkgs,
  inputs,
  system,
  ...
}:

with lib;

let
  cfg = config.modules.desktop.niri;
in
{
  options.modules.desktop.niri = {
    enable = lib.mkEnableOption "Enable Niri window manager";
    outputs = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        options = {
          name = lib.mkOption { type = lib.types.str; };
          mode = lib.mkOption { type = lib.types.str; };
          position = lib.mkOption { type = lib.types.str; };
          vrrOnDemand = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
        };
      });
      default = [];
      description = "Monitor output configurations";
    };
  };

  imports = [ inputs.niri-flake.nixosModules.niri ];

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bibata-cursors
      qt6.qtmultimedia
    ];

    programs.niri = {
      enable = true;
      package = inputs.niri-flake.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable;
    };

    programs.dms-shell = {
      enable = true;
      package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
      systemd = {
        enable = true; # Systemd service for auto-start
        restartIfChanged = true; # Auto-restart dms.service when dms-shell changes
      };

      # Core features
      enableSystemMonitoring = true; # System monitoring widgets (dgop)
      enableVPN = true; # VPN management widget
      enableDynamicTheming = true; # Wallpaper-based theming (matugen)
      enableAudioWavelength = true; # Audio visualizer (cava)
      enableCalendarEvents = true; # Calendar integration (khal)
      enableClipboardPaste = true; # Pasting from the clipboard history (wtype)
    };

    # DankGreeter using flake package
    services.displayManager.dms-greeter = {
      enable = true;
      compositor.name = "niri";
      configHome = "/home/mark";
      configFiles = [
        "/home/mark/.config/DankMaterialShell/settings.json"
      ];
      package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
      # compositor.customConfig = ''
      #   hotkey-overlay { skip-at-startup }
      #   environment { DMS_RUN_GREETER "1" }
      #   layout { background-color "#000000" }
      #   ${lib.concatMapStrings (out: ''
      #     output "${out.name}" {
      #       mode "${out.mode}"
      #       position "${out.position}"
      #       ${lib.optionalString (out.vrrOnDemand or false) "variable-refresh-rate true"}
      #     }
      #   '') cfg.outputs}
      # '';
      logs = {
        save = true;
        path = "/tmp/dms-greeter.log";
      };
    };

    users.groups.greeter = { };

    services.xserver.enable = true;
  };
}
