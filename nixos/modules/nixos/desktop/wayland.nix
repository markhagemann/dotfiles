{ options, config, lib, pkgs, inputs, ... }:
with lib;
let cfg = config.modules.desktop.wayland;
in {
  options.modules.desktop.wayland.enable =
    lib.mkEnableOption "Enable the wayland module";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ wl-clipboard ];
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      MOZ_WEBRENDER = "1";
    };
  };
}
