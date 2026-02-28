{
  config,
  pkgs,
  inputs,
  lib,
  nix-gaming,
  ...
}:

{
  boot = {
    # kernelPackages = pkgs.linuxPackages_xanmod_latest;
    # kernelPackages = pkgs.linuxPackages_zen;
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
    kernelParams = [
      "quiet"
      "nowatchdog"
      "threadirqs"
      "prempt=full"
      "sched_ext.enabled=1"
    ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

  };

  # Reduce SIGTERM time to 30s from default of 90s
  systemd.user.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';
}
