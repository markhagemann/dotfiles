{ config, pkgs, inputs, lib, nix-gaming, ... }:

{
  boot = {
    # kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages =
      pkgs.linuxKernel.packagesFor pkgs.cachyosKernels.linux-cachyos-latest;
    kernelParams = [ "quiet" "nowatchdog" "threadirqs" ];

    # 🧩 Sysctl tuning for gaming / desktop latency
    kernel.sysctl = {
      # 🧠 Reduce swapping — keep game assets in RAM
      "vm.swappiness" = 10;

      # 🚫 Disable autogroup (let Bore handle tasks directly)
      "kernel.sched_autogroup_enabled" = 0;

      # ⚙️ Reduce disk writeback delay (snappier I/O)
      "vm.dirty_ratio" = 10;
      "vm.dirty_background_ratio" = 5;

      # Optional — helps responsiveness for large page cache workloads
      "vm.vfs_cache_pressure" = 50;
    };

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
