{ config, pkgs, ... }:

{
  imports = [
#    ../../modules/desktop/hyprland/hyprland.nix
#    ../../modules/desktop/hyprland/waybar.nix
#    ../../modules/desktop/programs/spotify.nix
#    ../../modules/desktop/hyprland/cursor.nix
#    ../../modules/desktop/hyprland/rofi.nix
     ../../modules/desktop/browsers/firefox.nix
     ../../modules/desktop/programs/spotify.nix
     ../../modules/shell/mise.nix
  ];


  home.username = "mark";
  home.homeDirectory = "/home/mark";

  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # Fonts
    adwaita-icon-theme
    font-awesome

    # Terminals / shell tools
    bat
    eza
    fd
    fzf
    gnumake
    jq
    lazygit
    lazydocker
    libnotify
    mise
    nix-zsh-completions
    ripgrep
    starship
    tokei
    tree
    unzip
    zoxide

    # Productivity / general apps
    anki-bin
    obsidian
    qutebrowser
    calibre
    mpv

    # Network/Download tools
    dig
  ];


  modules.desktop.programs.spotify.enable = true;
  # modules.desktop.hyprland.cursor.enable = true;
  # modules.desktop.hyprland.rofi.enable = true;
  modules.shell.mise.enable = true;

  xdg = {
    userDirs = {
      enable = false;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_DESKTOP_DIR     = "$HOME";
    XDG_DOWNLOAD_DIR    = "$HOME/downloads";
    XDG_TEMPLATES_DIR   = "$HOME";
    XDG_PUBLICSHARE_DIR = "$HOME";
    XDG_DOCUMENTS_DIR   = "$HOME/documents";
    XDG_MUSIC_DIR       = "$HOME";
    XDG_PICTURES_DIR    = "$HOME/pictures";
    XDG_VIDEOS_DIR      = "$HOME";


    backupFileExtension = "backup";
  };
}
