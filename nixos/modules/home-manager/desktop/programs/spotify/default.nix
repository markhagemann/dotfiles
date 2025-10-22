{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.desktop.programs.spotify;
in {
  options.modules.desktop.programs.spotify = {
    enable = mkEnableOption "Spotify client with playerctl support";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ playerctl ]; };
}
