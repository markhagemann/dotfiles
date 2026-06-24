{
  pkgs,
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

  systemd.user.settings.Manager = {
    DefaultTimeoutStopSec = "10s";
  };
}
