{ lib, inputs, outputs, pkgs, home-manager, ... }:

{
  nixpkgs.config.allowUnfree = true;
  # Configure nix settings, including experimental features and garbage collection
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [ "root" "mark" ];
    };
    # gc = {
    #   automatic = true;
    #   options = "--delete-older-than 7d";
    # };
    optimise.automatic = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 5";
  };

  # Define shared packages to be installed on all hosts
  environment.systemPackages = with pkgs; [ git ];
}
