# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../hardware/radeon
    ../../modules/desktop/fonts.nix
    ../../modules/desktop/kde.nix
    ../../modules/desktop/wayland.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  chaotic.mesa-git.enable = true;

  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [
    atuin
    betterdiscordctl
    bitwarden
    btop
    cargo
    chezmoi
    clang
    cmake
    curl
    delta
    deluge-gtk
    discord
    ffmpeg
    gamescope
    gcc
    git
    goverlay
    kitty
    lact
    libreoffice-qt
    libffi.dev
    lutris
    # mako
    mangohud
    neovim
    opencode
    openssl
    openssl.dev
    pkg-config
    protonup-qt
    python312
    rustc
    steam
    # swaylock-effects
    # swayidle
    # st
    tmux
    vim
    # waybar
    wget
    wineWowPackages.stable
    winetricks
    # wofi
    wl-clipboard
    zlib.dev
  ];
  environment.variables.PKG_CONFIG_PATH =
    lib.makeSearchPath "lib/pkgconfig" [ pkgs.openssl.dev pkgs.zlib.dev ];

  fileSystems."/storage/4tb-ssd" = {
    device = "/dev/disk/by-uuid/a2074226-f644-49cb-b94b-b657f786c836";
    fsType = "btrfs";
    options = [ "compress=zstd" "noatime" ];
  };

  hardware.bluetooth.enable = true;

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
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  nixpkgs.config.allowUnfree = true; # Allow unfree packages
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.firefox.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
  programs.tmux.enable = true;
  programs.zsh.enable = true;
  # Wayland session
  #services.greetd = {
  #  enable = true;
  #  settings.default_session = {
  #    command = "${pkgs.hyprland}/bin/Hyprland";
  #    user = "mark";
  #  };
  # };

  services.lsfg-vk = {
    enable = true;
    ui.enable = true;
  };

  # security.pam.services.swaylock = {};

  # Configure keymap in X11
  services.xserver.xkb = { layout = "us"; };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  services.timesyncd.enable = true;
  time.hardwareClockInLocalTime = false;
  time.timeZone = "Australia/Brisbane";

  users.users.mark = {
    isNormalUser = true;
    description = "Mark";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs;
      [
        kdePackages.kate
        #  thunderbird
      ];
  };
}
