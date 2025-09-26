{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.fonts;
in {
  options.modules.desktop.fonts.enable = lib.mkEnableOption "Enable the fonts module";

  config = mkIf cfg.enable {
    fonts.enableDefaultPackages = true;
    fonts.packages = with pkgs; [
      # General fonts
      corefonts
      google-fonts

      # Monospace fonts
      fira-code
      jetbrains-mono

      pkgs.nerd-fonts.space-mono
      pkgs.nerd-fonts.overpass
      pkgs.nerd-fonts.ubuntu
    ];

    fonts.fontconfig = {
      antialias = true;
      hinting = {
        enable = true;
        style = "slight";
      };
      subpixel.rgba = "rgb";
    };
  };
}
