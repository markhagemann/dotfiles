{ config, lib, pkgs, inputs, ... }:

let
  pkgsMaster = import inputs.nixpkgs-master {
    system = pkgs.stdenv.hostPlatform.system;
    config = { allowUnfree = true; };
  };
in {
  environment.systemPackages = with pkgs; [ mesa-demos lact ];

  hardware.amdgpu.overdrive.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    package = pkgsMaster.mesa;
    package32 = pkgsMaster.pkgsi686Linux.mesa;
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
