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
      "preempt=full"
      "sched_ext.enabled=1"
    ];

    kernel.sysctl = {
      # Match SteamOS memory map limits to prevent crashes in heavy games or Proton
      "vm.max_map_count" = 2147483642;

      # Split lock mitigation can cause extreme stuttering in some games
      "kernel.split_lock_mitigate" = 0;
    };

    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 10;
      efi.canTouchEfiVariables = true;
    };

  };

  systemd.user.settings.Manager = {
    DefaultTimeoutStopSec = "10s";
  };
}
