{ lib, inputs, outputs, pkgs, home-manager, ... }:

{
  # Configure nix settings, including experimental features and garbage collection
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      substituters = [ "https://attic.xuyh0120.win/lantian" ];
      trusted-public-keys =
        [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];
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
