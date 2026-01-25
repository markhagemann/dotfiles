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
    imagemagick
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

    # Language / Servers / Linters that Mason can't run on NixOS
    lua5_1
    lua-language-server
    stylua

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

  # Doesn't support playlist yet - useless till then
  # services.linux-wallpaperengine = {
  #   enable = true;
  #   assetsPath =
  #     "${config.home.homeDirectory}/.local/share/Steam/steamapps/common/wallpaper_engine/assets";
  #
  #   wallpapers = [
  #     {
  #       monitor = "DP-1";
  #       wallpaperId = "2048819426";
  #       fps = 45;
  #       audio = { processing = false; silent = true; };
  #       scaling = "fill";
  #     }
  #     {
  #       monitor = "DP-1";
  #       wallpaperId = "3156173237";
  #       fps = 45;
  #       audio = { processing = false; silent = true; };
  #       scaling = "fill";
  #     }
  #     {
  #       monitor = "DP-1";
  #       wallpaperId = "3249337639";
  #       fps = 45;
  #       audio = { processing = false; silent = true; };
  #       scaling = "fill";
  #     }
  #     {
  #       monitor = "DP-1";
  #       wallpaperId = "3248789055";
  #       fps = 45;
  #       audio = { processing = false; silent = true; };
  #       scaling = "fill";
  #     }
  #     {
  #       monitor = "DP-1";
  #       wallpaperId = "3015692932";
  #       fps = 45;
  #       audio = { processing = false; silent = true; };
  #       scaling = "fill";
  #     }
  #     {
  #       monitor = "DP-1";
  #       wallpaperId = "3250483470";
  #       fps = 45;
  #       audio = { processing = false; silent = true; };
  #       scaling = "fill";
  #     }
  #     {
  #       monitor = "DP-1";
  #       wallpaperId = "3251349487";
  #       fps = 45;
  #       audio = { processing = false; silent = true; };
  #       scaling = "fill";
  #     }
  #     {
  #       monitor = "DP-1";
  #       wallpaperId = "2376341991";
  #       fps = 45;
  #       audio = { processing = false; silent = true; };
  #       scaling = "fill";
  #     }
  #     {
  #       monitor = "DP-1";
  #       wallpaperId = "1945149029";
  #       fps = 45;
  #       audio = { processing = false; silent = true; };
  #       scaling = "fill";
  #     }
  #     {
  #       monitor = "DP-1";
  #       wallpaperId = "3174492446";
  #       fps = 45;
  #       audio = { processing = false; silent = true; };
  #       scaling = "fill";
  #     }
  #     {
  #       monitor = "DP-1";
  #       wallpaperId = "3451450351";
  #       fps = 45;
  #       audio = { processing = false; silent = true; };
  #       scaling = "fill";
  #     }
  #     {
  #       monitor = "DP-1";
  #       wallpaperId = "3203241401";
  #       fps = 45;
  #       audio = { processing = false; silent = true; };
  #       scaling = "fill";
  #     }
  #     {
  #       monitor = "DP-1";
  #       wallpaperId = "3428926953";
  #       fps = 45;
  #       audio = { processing = false; silent = true; };
  #       scaling = "fill";
  #     }
  #     {
  #       monitor = "DP-1";
  #       wallpaperId = "3340426790";
  #       fps = 45;
  #       audio = { processing = false; silent = true; };
  #       scaling = "fill";
  #     }
  #     {
  #       monitor = "DP-1";
  #       wallpaperId = "3384222744";
  #       fps = 45;
  #       audio = { processing = false; silent = true; };
  #       scaling = "fill";
  #     }
  #     {
  #       monitor = "DP-1";
  #       wallpaperId = "2609314607";
  #       fps = 45;
  #       audio = { processing = false; silent = true; };
  #       scaling = "fill";
  #     }
  #     {
  #       monitor = "DP-1";
  #       wallpaperId = "2614505463";
  #       fps = 45;
  #       audio = { processing = false; silent = true; };
  #       scaling = "fill";
  #     }
  #     {
  #       monitor = "DP-1";
  #       wallpaperId = "2797293393";
  #       fps = 45;
  #       audio = {
  #         processing = false;
  #         silent = true;
  #       };
  #       scaling = "fill";
  #     }
  #     {
  #       monitor = "DP-1";
  #       wallpaperId = "1214148605";
  #       fps = 45;
  #       audio = {
  #         processing = false;
  #         silent = true;
  #       };
  #       scaling = "fill";
  #     }
  #   ];
  # };

  xdg = { userDirs = { enable = false; }; };
}
