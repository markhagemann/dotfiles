{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

with lib;

let
  cfg = config.modules.desktop.kde;
in
{

  options.modules.desktop.kde.enable = lib.mkEnableOption "Enable the kde module";

  config = mkIf cfg.enable {

    # Excluding some KDE applications from the default install
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      baloo-widgets
      elisa
      ffmpegthumbs
      konsole
      krdp
      plasma-browser-integration
    ];

    environment.systemPackages = with pkgs; [
      kara
      bibata-cursors
      inputs.kwin-effects-glass.packages.${pkgs.stdenv.hostPlatform.system}.default
      # sddm-astronaut
      # (sddm-astronaut.override { embeddedTheme = "purple_leaves"; })
    ];

    # Seems to be needed now with DMS greeter instead of plasma-login-manager
    security.pam.services.greetd.enableGnomeKeyring = true;
    services.desktopManager.plasma6.enable = true;

    # Don't enable plasma-login-manager - use DMS greeter instead for unified session selection
    services.displayManager = {
      plasma-login-manager = {
        enable = false;
      };
    };

    services.xserver = {
      enable = lib.mkDefault (!config.modules.desktop.wayland.enable);
    };
  };
}
