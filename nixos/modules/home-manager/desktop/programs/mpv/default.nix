{ pkgs, config, ... }:
# let custom-font = "placeholder"; in {
{
  programs.mpv = {
    enable = true;
    config = {
      autofit = "1600x900";
      osc = "no";
      pause = "no";
      # Terminal
      msg-color = "yes";
      ytdl-raw-options = "cookies-from-browser=firefox";
      msg-module = "yes";
      osd-bar = "no";
      profile = "high-quality";
      vo = "gpu-next";
      # loop-file = "inf";
      hwdec = "vaapi";
      geometry = "50%:50%";
      gpu-context = "wayland";
      scale = "ewa_lanczossharp";
      cscale = "ewa_lanczossharp";
      save-position-on-quit = "yes";
      video-sync = "display-resample";
      interpolation = "yes";
      tscale = "oversample";
      # slang = "sv,de,nl,en,eng";
      # alang = "ja,jp,jpn,en,eng";
      image-display-duration = "inf";
      # osd-font = "${custom-font.lato}";
      cache = "yes";
      volume = 80;
      demuxer-max-bytes = "650MiB";
      demuxer-max-back-bytes = "50MiB";
      demuxer-readahead-secs = "60";
      border = "no";
      keepaspect-window = "no";
    };
    scripts = with pkgs.mpvScripts; [
      mpris
      autoload
      mpv-cheatsheet-ng
      youtube-upnext
      memo
      reload
      uosc
      thumbfast
      sponsorblock
    ];
  };
  home.file."${config.xdg.configHome}/mpv/script-opts" = {
    source = ./opts;
    recursive = true;
  };
}
