{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

with lib;

let
  cfg = config.modules.desktop.mango;
in
{
  options.modules.desktop.mango = {
    enable = lib.mkEnableOption "Enable Mango window manager";
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

  imports = [ inputs.mango.nixosModules.mango ];

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bibata-cursors
      qt6.qtmultimedia
    ];

    programs.mango = {
      enable = true;
    };

    services.xserver.enable = true;
  };
}