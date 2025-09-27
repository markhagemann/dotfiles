{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ lact ];
  hardware.amdgpu.overdrive.enable = true;

  hardware.graphics.extraPackages = with pkgs; [ mesa ];

  systemd.services.lact = {
    description = "AMDGPU Control Daemon";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = { ExecStart = "${pkgs.lact}/bin/lact daemon"; };
    enable = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
}
