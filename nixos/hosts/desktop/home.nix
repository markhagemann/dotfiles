{ config, inputs, pkgs, ... }:

{
  imports = [
    # ../../modules/desktop/hyprland/default.nix
    ../../modules/desktop/browsers/firefox.nix
    ../../modules/desktop/programs/spotify.nix
    ../../modules/shell/mise.nix
    inputs.textfox.homeManagerModules.default
  ];

  home.homeDirectory = "/home/mark";
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
    calibre
    mpv

    # Network/Download tools
    dig

    # Gaming
    mangohud
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_DESKTOP_DIR = "$HOME";
    XDG_DOWNLOAD_DIR = "$HOME/downloads";
    XDG_TEMPLATES_DIR = "$HOME";
    XDG_PUBLICSHARE_DIR = "$HOME";
    XDG_DOCUMENTS_DIR = "$HOME/documents";
    XDG_MUSIC_DIR = "$HOME";
    XDG_PICTURES_DIR = "$HOME/pictures";
    XDG_VIDEOS_DIR = "$HOME";

    backupFileExtension = "backup";
  };
  home.username = "mark";
  home.stateVersion = "25.05"; # Please read the comment before changing.

  modules.desktop.programs.spotify.enable = true;
  # modules.desktop.hyprland.cursor.enable = true;
  # modules.desktop.hyprland.rofi.enable = true;
  modules.shell.mise.enable = true;

  programs.mangohud.enable = true;

  # TODO: Need to configure this properly... the sidebery defaults aren't nice for pinned tabs
  # textfox = {
  #   enable = true;
  #   profile = "default";
  #   config = {
  #     font = { family = "Poppins"; };
  #     sidebery = { margin = "0.2rem"; };
  #   };
  # };

  xdg = { userDirs = { enable = false; }; };
}
