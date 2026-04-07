{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../../modules/home-manager/desktop/dms.nix
    ../../modules/home-manager/desktop/kde.nix
    ../../modules/home-manager/desktop/niri
    ../../modules/home-manager/desktop/browsers/firefox.nix
    ../../modules/home-manager/desktop/programs/spotify/default.nix
    ../../modules/home-manager/desktop/programs/spotify/spicetify.nix
    ../../modules/home-manager/desktop/programs/mpv
    # Using linux-wallpaperengine GUI via flatpak instead for now
    # https://github.com/jagrat7/linux-wallpaper-engine
    # ../../modules/home-manager/desktop/wallpaper-engine.nix
    ../../modules/home-manager/services/flatpak.nix
    ../../modules/home-manager/shell/mise.nix
    inputs.textfox.homeManagerModules.default
    inputs.dms.homeModules.dank-material-shell
  ];

  # Toggle between KDE and Niri:
  modules.desktop.niri.enable = true;
  modules.desktop.niri.customThemeFile = "${config.home.homeDirectory}/.config/DankMaterialShell/themes/tokyonight-moon.json";
  modules.desktop.niri.outputs = [
    {
      name = "Dell Inc. Dell AW2721D #GjMYMxgwABQF";
      mode = "2560x1440@239.970";
      position = "x=0 y=0";
      identifier = "DP-2";
      model = "Dell AW2721D";
      bar = true;
    }
    {
      name = "Dell Inc. AW2725DF 8755ZZ3";
      mode = "2560x1440@359.979";
      position = "x=2560 y=0";
      vrrOnDemand = true;
      videoWallpaper = true;
      identifier = "DP-1";
    }
  ];

  # modules.desktop.kde.enable = true;

  home.homeDirectory = "/home/mark";
  home.packages = with pkgs; [
    # Fonts
    # adwaita-icon-theme
    font-awesome

    # Terminals / shell tools
    bat
    eza
    fastfetch
    fd
    fzf
    gnumake
    imagemagick
    jq
    lazygit
    lazydocker
    libnotify
    mise
    nix-zsh-completions
    posting
    ripgrep
    starship
    superfile
    tokei
    tree
    tree-sitter
    unzip
    yq
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

  home.file = {
    ".config/environment.d/30-desktop-theme.conf".text = ''
      EDITOR=nvim
      VISUAL=nvim
      QT_QPA_PLATFORM=wayland
      QT_QPA_PLATFORMTHEME=qt6ct
      QS_ICON_THEME=Vivid-Dark-Icons
      ELECTRON_OZONE_PLATFORM_HINT=wayland
      MOZ_ENABLE_WAYLAND=1
      TERMINAL=kitty
    '';
  };

  home.username = "mark";
  home.stateVersion = "25.05"; # Please read the comment before changing.

  modules.desktop.programs.spotify.enable = true;
  # modules.desktop.wallpaperEngine.enable = false;
  modules.shell.mise.enable = true;

  programs.mangohud.enable = true;
  programs.neovim = {
    enable = false;
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

  xdg = {
    userDirs = {
      enable = false;
    };
  };
}
