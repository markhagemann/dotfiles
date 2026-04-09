{
  config,
  lib,
  pkgs,
  inputs,
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
      type = lib.types.listOf (
        lib.types.submodule {
          options = {
            name = lib.mkOption { type = lib.types.str; };
            identifier = lib.mkOption { type = lib.types.str; };
            mode = lib.mkOption { type = lib.types.str; };
            position = lib.mkOption { type = lib.types.str; };
            vrrOnDemand = lib.mkOption {
              type = lib.types.bool;
              default = false;
            };
          };
        }
      );
      default = [ ];
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

    # DankGreeter using flake package
    services.displayManager.dms-greeter = {
      enable = true;
      compositor.name = "niri";
      compositor.customConfig = ''
        ${lib.concatMapStrings (
          out:
          let
            screenName = out.identifier or out.name;
          in
          ''
            output "${screenName}" {
              mode "${out.mode}"
              position ${out.position}
            }
          ''
        ) cfg.outputs}


        hotkey-overlay {
          skip-at-startup
        }

        cursor {
            xcursor-theme "Bibata-Modern-Ice"
            xcursor-size 24
            hide-when-typing
            hide-after-inactive-ms 5000
        }
      '';
      configHome = "/home/mark";
      configFiles = [
        "/home/mark/.config/DankMaterialShell/settings.json"
        "/home/mark/.local/state/DankMaterialShell/session.json"
        "/home/mark/.cache/quickshell/dankshell/dms-colors.json"
      ];
      package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
      logs = {
        save = true;
        path = "/tmp/dms-greeter.log";
      };
    };

    users.groups.greeter = { };

    services.xserver.enable = true;
  };
}
