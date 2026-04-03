{
  lib,
  inputs,
  outputs,
  pkgs,
  home-manager,
  ...
}:

{
  # Configure nix settings, including experimental features and garbage collection
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      substituters = [ "https://attic.xuyh0120.win/lantian" ];
      trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];
      trusted-users = [
        "root"
        "mark"
      ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    optimise.automatic = true;
  };

  # Define shared packages to be installed on all hosts
  environment.systemPackages = with pkgs; [
    atuin
    betterdiscordctl
    bitwarden-desktop
    bob-nvim
    btop
    cargo
    chezmoi
    chromium
    clang
    cmake
    curl
    delta
    docker-compose
    discord
    dmidecode
    extra-cmake-modules
    gcc
    libffi.dev
    ffmpeg
    flatpak
    git
    just
    kitty
    ntfs3g
    opencode
    openssl
    openssl.dev
    pgcli
    pkg-config
    python313
    unrar
    rustc
    tmux
    vim
    wget
    usbutils
    zlib.dev
  ];
}
