{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/desktop/kde.nix
    # ../../modules/home-manager/desktop/niri
    ../../modules/home-manager/desktop/browsers/firefox.nix
    ../../modules/home-manager/desktop/programs/spotify/default.nix
    ../../modules/home-manager/desktop/programs/spotify/spicetify.nix
    ../../modules/home-manager/desktop/programs/mpv
    ../../modules/home-manager/services/flatpak.nix
    ../../modules/home-manager/shell/mise.nix
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
    neofetch
    nix-zsh-completions
    posting
    ripgrep
    starship
    superfile
    tokei
    tree
    unzip
    zoxide

    # Language Servers / Linters that Mason can't run on NixOS
    stylua
    lua-language-server

    # Productivity / general apps
    anki-bin
    obsidian
    calcure
    calibre

    # Network/Download tools
    dig

    # Gaming
    mangohud

    # Media
    vlc
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";

    XDG_CONFIG_HOME = lib.mkForce "$HOME/.config";
    XDG_DATA_HOME = lib.mkForce "$HOME/.local/share";
    XDG_CACHE_HOME = lib.mkForce "$HOME/.cache";
    XDG_DESKTOP_DIR = lib.mkForce "$HOME";
    XDG_DOWNLOAD_DIR = lib.mkForce "$HOME/downloads";
    XDG_TEMPLATES_DIR = lib.mkForce "$HOME";
    XDG_PUBLICSHARE_DIR = lib.mkForce "$HOME";
    XDG_DOCUMENTS_DIR = lib.mkForce "$HOME/documents";
    XDG_MUSIC_DIR = lib.mkForce "$HOME";
    XDG_PICTURES_DIR = lib.mkForce "$HOME/pictures";
    XDG_VIDEOS_DIR = lib.mkForce "$HOME";

    backupFileExtension = "backup";
  };
  home.username = "mark";
  home.stateVersion = "25.05"; # Please read the comment before changing.

  modules.desktop.programs.spotify.enable = true;
  # modules.desktop.hyprland.cursor.enable = true;
  # modules.desktop.hyprland.rofi.enable = true;
  modules.shell.mise.enable = true;

  programs.mangohud.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraLuaPackages = ps: [ ps.lua ps.luarocks-nix ps.magick ];
    extraPackages = with pkgs; [ xclip imagemagick ];
  };

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
