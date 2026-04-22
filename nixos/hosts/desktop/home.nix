{
  config,
  inputs,
  lib,
  pkgs,
  osConfig,
  ...
}:

{
  imports = [
    ../../modules/home-manager/desktop/dms.nix
    ../../modules/home-manager/desktop/kde.nix
    ../../modules/home-manager/desktop/niri
    ../../modules/home-manager/desktop/mango
    ../../modules/home-manager/desktop/browsers/firefox.nix
    ../../modules/home-manager/desktop/programs/spotify/default.nix
    ../../modules/home-manager/desktop/programs/spotify/spicetify.nix
    ../../modules/home-manager/desktop/programs/mpv
    # linux-wallpaperengine GUI is nice but not working properly for playlist
    # https://github.com/jagrat7/linux-wallpaperengine
    ../../modules/home-manager/desktop/wallpaper-engine.nix
    ../../modules/home-manager/services/flatpak.nix
    ../../modules/home-manager/shell/mise.nix
    inputs.textfox.homeManagerModules.default
    inputs.dms.homeModules.dank-material-shell
    inputs.mango.hmModules.mango
  ];

  # Toggle between Niri, Mango, and KDE based on system config
  modules.desktop.niri.enable = osConfig.modules.desktop.niri.enable or false;
  modules.desktop.niri.outputs = osConfig.modules.desktop.niri.outputs or [ ];
  modules.desktop.niri.customThemeFile = "${config.home.homeDirectory}/.config/DankMaterialShell/themes/tokyonight-moon.json";

  modules.desktop.mango.enable = osConfig.modules.desktop.mango.enable or false;
  modules.desktop.mango.outputs = osConfig.modules.desktop.mango.outputs or [ ];

  modules.desktop.kde.enable = osConfig.modules.desktop.kde.enable or false;

  # Enable dms for niri/mango, not for kde
  modules.desktop.dms.enable =
    osConfig.modules.desktop.niri.enable or osConfig.modules.desktop.mango.enable or false;
  modules.desktop.dms.monitors =
    osConfig.modules.desktop.niri.outputs or (osConfig.modules.desktop.mango.outputs or [ ]);

  home.homeDirectory = "/home/mark";
  home.packages = with pkgs; [
    # Shared utilities
    adw-gtk3
    nwg-look # for customizing adw-gtk3
    qt6Packages.qt6ct
    qimgv
    udiskie

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
      ELECTRON_OZONE_PLATFORM_HINT=auto
      MOZ_ENABLE_WAYLAND=1
      TERMINAL=kitty
      VISUAL=nvim
    '';

    ".local/bin/raise-cycle-or-spawn" = {
      source = ../../modules/home-manager/desktop/scripts/raise-cycle-or-spawn.sh;
      executable = true;
    };
  };

  home.username = "mark";
  home.stateVersion = "25.05"; # Please read the comment before changing.

  modules.desktop.programs.spotify.enable = true;
  modules.desktop.wallpaperEngine.enable = false;
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

  programs.vesktop = {
    enable = true;
    settings = {
      appBadge = true;
      arRPC = true;
      checkUpdates = false;
      customTitleBar = false;
      disableMinSize = true;
      minimizeToTray = true;
      tray = true;
      splashBackground = "#282a37";
      splashColor = "#bb9af7";
      splashTheming = true;
      staticTitle = true;
      hardwareAcceleration = true;
      discordBranch = "stable";
    };
  };

  xdg = {
    userDirs = {
      enable = false;
    };
  };
}
