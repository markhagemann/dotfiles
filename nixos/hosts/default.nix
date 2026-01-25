{ lib, inputs, outputs, pkgs, home-manager, ... }:

{
  # Configure nix settings, including experimental features and garbage collection
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [ "root" "mark" ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    optimise.automatic = true;
  };

  # Define shared packages to be installed on all hosts
  environment.systemPackages = with pkgs; [ git ];
}
