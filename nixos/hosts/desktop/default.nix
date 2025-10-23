# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./boot.nix
    ./hardware-configuration.nix
    ../../hardware/bluetooth
    ../../hardware/cpu
    ../../hardware/radeon
    ../../modules/nixos/desktop/fonts.nix
    ../../modules/nixos/desktop/kde.nix
    ../../modules/nixos/desktop/niri.nix
    ../../modules/nixos/desktop/wayland.nix
    ../../modules/nixos/utility/display-switch
  ];

  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [
    atuin
    betterdiscordctl
    bitwarden
    boxflat
    btop
    cargo
    chezmoi
    chromium
    clang
    cmake
    curl
    delta
    deluge-gtk
    ddcutil
    discord
    docker-compose
    easyeffects
    ffmpeg
    flatpak
    gamescope
    gcc
    git
    gpu-screen-recorder-gtk
    kitty
    libffi.dev
    libreoffice-qt
    librewolf
    lutris
    ntfs3g
    opencode
    openssl
    openssl.dev
    pkg-config
    protonup-qt
    python312
    rustc
    steam
    tmux
    vim
    wget
    wineWowPackages.stable
    wineWowPackages.staging
    wineWowPackages.waylandFull
    winetricks
    wireguard-tools
    wowup-cf
    usbutils
    zlib.dev
  ];
  environment.variables = {
    MANGOHUD = "1";
    MANGOHUD_DLSYM = "1";
    PKG_CONFIG_PATH =
      lib.makeSearchPath "lib/pkgconfig" [ pkgs.openssl.dev pkgs.zlib.dev ];
  };

  fileSystems."/storage/4tb-ssd" = {
    device = "/dev/disk/by-uuid/a2074226-f644-49cb-b94b-b657f786c836";
    fsType = "btrfs";
    options = [ "compress=zstd" "noatime" ];
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

  modules = {
    desktop = {
      niri.enable = false;
      kde.enable = true;
      fonts.enable = true;
      wayland.enable = true;

      # browsers = {
      #   default = "librewolf";
      #   librewolf.enable = true;
      #   chromium.enable = true;
      # };
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

  nixpkgs.config.allowUnfree = true; # Allow unfree packages
  nixpkgs.overlays = [ (import ../../overlays/pkgs.nix) ];

  programs.firefox.enable = true;
  programs.gamemode.enable = true;
  programs.gpu-screen-recorder.enable = true;
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
  programs.tmux.enable = true;
  programs.zsh.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.flatpak.enable = true;

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

  services.timesyncd.enable = true;
  services.udev.packages = [ pkgs.boxflat ];

  # Configure keymap in X11
  services.xserver.xkb = { layout = "us"; };

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
    description = "Mark";
    shell = pkgs.zsh;
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    packages = with pkgs;
      [
        kdePackages.kate
        #  thunderbird
      ];
  };

  virtualisation.docker.enable = true;
}
