{ options, config, lib, pkgs, inputs, system, ... }:

with lib;

let cfg = config.modules.desktop.niri;
in {

  options.modules.desktop.niri.enable =
    lib.mkEnableOption "Enable the niri module";

  config = mkIf cfg.enable {
    programs.niri = {
      enable = true;
      package = inputs.niri-flake.packages.${system}.niri-unstable;
    };

  };
}

