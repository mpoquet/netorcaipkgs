{ stdenv, buildGoPackage, fetchgit }:

buildGoPackage rec {
  name = "netorcai-${version}";
  version = "1.0.0";
  rev = "v${version}";

  goPackagePath = "github.com/mpoquet/netorcai";

  src = fetchgit {
    inherit rev;
    url = "https://github.com/mpoquet/netorcai.git";
    sha256 = "016grc118yafa7sbn7h8lrqp21hc9awknhs5rcz6br181nkqbk02";
  };

  goDeps = ./deps.nix;

  meta = {
    description = "A network orchestrator for artificial intelligence games";
    homepage = "https://github.com/mpoquet/netorcai";
    license = stdenv.lib.licenses.gpl3;
    platforms = stdenv.lib.platforms.linux;
  };
}
