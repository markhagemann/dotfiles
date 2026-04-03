{
  options,
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
      inputs.kwin-effects-glass.packages.${pkgs.system}.default
      # sddm-astronaut
      # (sddm-astronaut.override { embeddedTheme = "purple_leaves"; })
    ];

    services.desktopManager.plasma6.enable = true;

    # At this stage you will have to run "Apply Plasma Settings"
    # You will also need to run `cp -rf ~/.local/share/icons/* /usr/share/icons`
    services.displayManager.plasma-login-manager = {
      enable = true;
      # Runs on wayland by default - would need an inverse to set it to below when wayland disabled
      # services.displayManager.defaultSession = "plasmax11";
    };

    # services.displayManager.sddm = {
    #   enable = true;
    #   theme = "sddm-astronaut-theme";
    #   settings.Theme.CursorTheme = "Bibata-Modern-Ice";
    #   wayland.enable = config.modules.desktop.wayland.enable;
    #   wayland.compositor = "kwin";
    #   # These are meant to be propagated by the package?
    #   extraPackages = with pkgs; [
    #     kdePackages.qtsvg
    #     kdePackages.qtmultimedia
    #     kdePackages.qtvirtualkeyboard
    #     kdePackages.qtdeclarative
    #     gst_all_1.gstreamer
    #     gst_all_1.gst-plugins-base
    #     gst_all_1.gst-plugins-good
    #     gst_all_1.gst-plugins-bad
    #     gst_all_1.gst-libav
    #     sddm-astronaut
    #   ];
    # };

    services.xserver = {
      enable = !config.modules.desktop.wayland.enable;
    };
  };
}
