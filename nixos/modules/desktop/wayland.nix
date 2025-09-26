{ options, config, lib, pkgs, inputs, ... }:
with lib;
let cfg = config.modules.desktop.wayland;
in {
  options.modules.desktop.wayland.enable =
    lib.mkEnableOption "Enable the wayland module";

  config =
    mkIf cfg.enable { environment.sessionVariables.NIXOS_OZONE_WL = "1"; };
}
