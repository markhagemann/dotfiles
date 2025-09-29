# Taken from: https://www.monotux.tech/posts/2023/05/nixos-overlay/
{ lib, stdenv, fetchFromGitHub, rustPlatform, udev, pkg-config }:

rustPlatform.buildRustPackage rec {
  pname = "display-switch";
  version = "dev";

  src = fetchFromGitHub {
    owner = "haimgel";
    repo = "display-switch";
    rev = "1.1.0";
    sha256 = "sha256-jucXTVuC3H7/fkn9Z/d2ElbpRI135EooYnCfRIVuUy0=";
  };

  cargoHash = "sha256-rXLFoXyctrs84R3bKgk9lVa33l23V8v3XoqrSzC0y5o=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ udev ];

  doCheck = false;

  meta = with lib; {
    description =
      "Turn a $30 USB switch into a full-featured multi-monitor KVM switch";
    homepage = "https://github.com/haimgel/display-switch";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all; # Linux, Darwin, Windows
  };
}
