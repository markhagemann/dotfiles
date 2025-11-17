self: super: {
  display-switch =
    super.callPackage ../modules/nixos/utility/display-switch/package.nix { };

  # # Override Firefox from nixos-unstable
  # firefox-unwrapped = let
  #   unstablePkgs = import (fetchTarball {
  #     url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  #     sha256 = "sha256-YRqMDEtSMbitIMj+JLpheSz0pwEr0Rmy5mC7myl17xs=";
  #   }) { system = super.system; };
  # in unstablePkgs.firefox-unwrapped;
}
