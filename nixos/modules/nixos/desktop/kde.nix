{ options, config, lib, pkgs, inputs, ... }:

with lib;

let cfg = config.modules.desktop.kde;
in {

  options.modules.desktop.kde.enable =
    lib.mkEnableOption "Enable the kde module";

  config = mkIf cfg.enable {

    # Excluding some KDE applications from the default install
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      baloo-widgets
      elisa
      ffmpegthumbs
      konsole
      krdp
      plasma-browser-integration
      xwaylandvideobridge
    ];

    services.displayManager.sddm = {
      enable = true;
      settings.Theme.CursorTheme = "Yaru";
      wayland.enable = config.modules.desktop.wayland.enable;
      wayland.compositor = "kwin";
    };

    services.desktopManager.plasma6.enable = true;

    services.xserver = { enable = !config.modules.desktop.wayland.enable; };
  };
}

