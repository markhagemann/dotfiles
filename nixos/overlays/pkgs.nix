final: prev: {
  display-switch = prev.callPackage ../modules/nixos/utility/display-switch/package.nix { };

  kde-rounded-corners = prev.kde-rounded-corners.overrideAttrs (oldAttrs: {
    src = prev.fetchFromGitHub {
      owner = "matinlotfali";
      repo = "KDE-Rounded-Corners";
      rev = "2cf9329b31b3152e5513f7069c4bb11c765fdc6e";
      sha256 = "sha256-mVoLCnpWHC2qDouO97n2cmxiewLCokjnWl1I9tnkIN4=";
    };
  });

  # # Override Firefox from nixos-unstable
  # firefox-unwrapped = let
  #   unstablePkgs = import (fetchTarball {
  #     url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  #     sha256 = "sha256-YRqMDEtSMbitIMj+JLpheSz0pwEr0Rmy5mC7myl17xs=";
  #   }) { system = super.system; };
  # in unstablePkgs.firefox-unwrapped;
}
