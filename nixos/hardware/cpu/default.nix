{ config, lib, pkgs, ... }:

{
  services.ananicy.enable = false;
  services.ananicy.package = pkgs.ananicy-cpp;
  services.ananicy.rulesProvider = pkgs.ananicy-rules-cachyos;
}
