# Refer to https://gitlab.com/theblackdon/black-don-os/-/blob/main/modules/home/niri/niri.nix?ref_type=heads
{ options, config, lib, pkgs, inputs, system, ... }:

with lib;

let cfg = config.modules.desktop.niri;
in {

  options.modules.desktop.niri.enable =
    lib.mkEnableOption "Enable the niri module";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      inputs.noctalia.packages.${system}.default
      kdePackages.dolphin
      kdePackages.kio-fuse
      kdePackages.kio-extras
      kdePackages.qtsvg
      kdePackages.breeze-icons
      waypaper
    ];

    programs.niri = {
      enable = true;
      package = inputs.niri-flake.packages.${system}.niri-unstable.overrideAttrs
        (old: { doCheck = false; });
    };

    services.displayManager.gdm.enable = true;
    # enable the systemd service
    services.noctalia-shell.enable = true;

    services.xserver = { enable = !config.modules.desktop.wayland.enable; };
  };
}

