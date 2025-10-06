{ config, pkgs, inputs, lib, chaotic, nix-gaming, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
