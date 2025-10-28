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
      # xwaylandvideobridge # does not appear to be on unstable anymore
    ];

    environment.systemPackages = with pkgs; [
      inputs.kwin-effects-forceblur.packages.${pkgs.system}.default # Wayland
      sddm-astronaut
    ];

    services.desktopManager.plasma6.enable = true;

    services.displayManager.sddm = {
      enable = true;
      theme = "sddm-astronaut-theme";
      settings.Theme.CursorTheme = "Bibata-Modern-Ice";
      wayland.enable = config.modules.desktop.wayland.enable;
      wayland.compositor = "kwin";
      # These are meant to be propagated by the package?
      extraPackages = with pkgs; [
        kdePackages.qtmultimedia
        kdePackages.qtsvg
        kdePackages.qtvirtualkeyboard
      ];
    };

    services.xserver = { enable = !config.modules.desktop.wayland.enable; };
  };
}

