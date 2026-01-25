{ config, lib, pkgs, ... }:

{
  # chaotic.mesa-git.enable = true;
  environment.systemPackages = with pkgs; [ mesa-demos lact ];

  hardware.amdgpu.overdrive.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  systemd.services.lact = {
    description = "AMDGPU Control Daemon";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = { ExecStart = "${pkgs.lact}/bin/lact daemon"; };
    enable = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
}
