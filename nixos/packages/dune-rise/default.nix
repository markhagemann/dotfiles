{ lib, stdenvNoCC }:

stdenvNoCC.mkDerivation {
  pname = "dune-rise";
  version = "1.0";

  src = ../../assets/fonts/dune-rise;

  installPhase = ''
    runHook preInstall
    install -Dm644 Dune_Rise.ttf -t $out/share/fonts/truetype/dune-rise
    install -Dm644 Dune_Rise.otf -t $out/share/fonts/opentype/dune-rise
    install -Dm644 License.txt -t $out/share/doc/dune-rise
    runHook postInstall
  '';

  meta = with lib; {
    description = "Dune Rise display font";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}