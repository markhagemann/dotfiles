{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.desktop.wallpaperEngine;
in

{
  options.modules.desktop.wallpaperEngine = {
    enable = lib.mkEnableOption "wallpaper engine playlist rotation";
    assetsPath = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/.local/share/Steam/steamapps/common/wallpaper_engine/assets";
    };
  };

  config = lib.mkIf cfg.enable (
    let
      commonArgs = "--screen-root DP-1 --fps 45 --scaling fill --silent --no-audio-processing --fullscreen-pause-only-active";

      wallpaperIds = [
        "3156173237"
        "3249337639"
        "3248789055"
        "3015692932"
        "3250483470"
        "3251349487"
        "2376341991"
        "1945149029"
        "3174492446"
        "3451450351"
        "3203241401"
        "3428926953"
        "3340426790"
        "3384222744"
        "2609314607"
        "2614505463"
        "2797293393"
        "1214148605"
      ];

      playlistScript = pkgs.writeShellScriptBin "wpe-playlist" ''
        ids=(${lib.concatStringsSep " " wallpaperIds})
        shuf="${pkgs.coreutils}/bin/shuf"

        while true; do
          for id in $("$shuf" -e "''${ids[@]}"); do
            echo "Switching to wallpaper: $id"
            ${pkgs.linux-wallpaperengine}/bin/linux-wallpaperengine ${commonArgs} --assets-path "${cfg.assetsPath}" --bg "$id" &
            WPE_PID=$!
            ${pkgs.coreutils}/bin/sleep 60
            kill $WPE_PID 2>/dev/null
            wait $WPE_PID 2>/dev/null
          done
        done
      '';
    in
    {
      services.linux-wallpaperengine.enable = true;
      home.packages = [
        pkgs.linux-wallpaperengine
        playlistScript
        pkgs.coreutils
        pkgs.procps
      ];

      systemd.user.services.linux-wallpaperengine-playlist = {
        Unit = {
          Description = "Linux Wallpaper Engine Playlist";
          After = [ "graphical-session.target" ];
          PartOf = [ "graphical-session.target" ];
        };
        Service = {
          ExecStart = "${playlistScript}/bin/wpe-playlist";
          Restart = "always";
        };
        Install.WantedBy = [ "graphical-session.target" ];
      };
    }
  );
}
