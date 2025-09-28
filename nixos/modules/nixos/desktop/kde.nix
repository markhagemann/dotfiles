{ options, config, lib, pkgs, inputs, ... }:

with lib;

let cfg = config.modules.desktop.kde;
in {

  options.modules.desktop.kde.enable =
    lib.mkEnableOption "Enable the kde module";

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs;
      [
        kde-rounded-corners
        # kdePackages.wallpaper-engine-plugin # TODO: Crashes plasmashell and sometimes ends up immutable
      ];

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = config.modules.desktop.wayland.enable;
      wayland.compositor = "kwin";
    };

    services.desktopManager.plasma6.enable = true;

    services.xserver = { enable = !config.modules.desktop.wayland.enable; };
  };
}

