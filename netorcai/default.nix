{ stdenv, buildGoPackage, fetchgit }:

buildGoPackage rec {
  name = "netorcai-${version}";
  version = "1.0.1";
  rev = "v${version}";

  goPackagePath = "github.com/netorcai/netorcai";

  src = fetchgit {
    inherit rev;
    url = "https://github.com/netorcai/netorcai.git";
    sha256 = "0r88y0vah491281v3k9ryjijgvcbkg17v45jmbcd08nizfijvp8d";
  };

  goDeps = ./deps.nix;

  meta = {
    description = "A network orchestrator for artificial intelligence games";
    homepage = "https://github.com/netorcai/netorcai";
    license = stdenv.lib.licenses.gpl3;
    platforms = stdenv.lib.platforms.linux;
  };
}
