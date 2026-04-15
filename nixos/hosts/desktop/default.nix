# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  lib,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./boot.nix
    ./hardware-configuration.nix
    ../../hardware/bluetooth
    ../../hardware/cpu
    ../../hardware/radeon
    ../../modules/nixos/desktop/fonts.nix
    ../../modules/nixos/desktop/kde.nix
    ../../modules/nixos/desktop/niri.nix
    ../../modules/nixos/desktop/mangowc.nix
    ../../modules/nixos/desktop/dms.nix
    ../../modules/nixos/desktop/wayland.nix
    ../../modules/nixos/utility/display-switch
  ];

  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [
    boxflat
    deluge-gtk
    ddcutil
    easyeffects
    faugus-launcher
    # gamescope-wsi
    lutris
    protonup-qt
    steam
    wineWow64Packages.stable
    wineWow64Packages.staging
    wineWow64Packages.waylandFull
    winetricks
    wireguard-tools
    wowup-cf
  ];
  environment.variables = {
    MANGOHUD = "1";
    MANGOHUD_DLSYM = "1";
    PKG_CONFIG_PATH = lib.makeSearchPath "lib/pkgconfig" [
      pkgs.openssl.dev
      pkgs.zlib.dev
    ];
  };

  fileSystems."/storage/4tb-ssd" = {
    device = "/dev/disk/by-uuid/a2074226-f644-49cb-b94b-b657f786c836";
    fsType = "btrfs";
    options = [
      "compress=zstd"
      "noatime"
    ];
  };

  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  modules =
    let
      monitors = [
        {
          name = "Dell Inc. Dell AW2721D #GjMYMxgwABQF";
          identifier = "DP-2";
          mode = "2560x1440@239.970";
          position = "x=0 y=0";
          bar = true;
        }
        {
          name = "Dell Inc. AW2725DF 8755ZZ3";
          identifier = "DP-1";
          mode = "2560x1440@359.979";
          position = "x=2560 y=0";
          vrrOnDemand = true;
        }
      ];
    in
    {
      desktop = {
        niri.enable = true;
        niri.outputs = monitors;
        mango.enable = false;
        mango.outputs = monitors;
        kde.enable = true;
        fonts.enable = true;
        wayland.enable = true;
      };
    };

  networking.hostName = "desktop"; # Define your hostname.
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.networkmanager.enable = true; # Enable networking
  networking.networkmanager.plugins = with pkgs; [ networkmanager-openvpn ];
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  programs.firefox.enable = true;
  programs.gamemode.enable = true;
  # programs.gamescope.enable = true;
  # Download via Discover for the moment - need gpu-screen-recorder-ui merge to be approved
  # programs.gpu-screen-recorder.enable = true;
  programs.nix-ld.enable = true;
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
  programs.tmux.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.flatpak = {
    enable = true;
    packages = [
      "io.gitlab.librewolf-community"
      "org.libreoffice.LibreOffice"
    ];
    # packages = [ "com.dec05eba.gpu_screen_recorder" ];
  };

  # security.pam.services.swaylock = {};
  services.lsfg-vk = {
    enable = true;
    ui.enable = true;
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };

  services.timesyncd.enable = true;
  services.udev.packages = [ pkgs.boxflat ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  time.hardwareClockInLocalTime = false;
  time.timeZone = "Australia/Brisbane";

  users.users.mark = {
    isNormalUser = true;
    ignoreShellProgramCheck = true;
    description = "Mark";
    shell = pkgs.zsh;
    extraGroups = [
      "docker"
      "greeter"
      "networkmanager"
      "video"
      "wheel"
    ];
    packages = with pkgs; [
      kdePackages.kate
      #  thunderbird
    ];
  };

  virtualisation.docker.enable = true;
}
