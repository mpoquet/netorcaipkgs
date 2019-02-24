{ stdenv, buildGoPackage, fetchgit }:

buildGoPackage rec {
  name = "netorcai-${version}";
  version = "2.0.0";
  rev = "v${version}";

  goPackagePath = "github.com/netorcai/netorcai";

  src = fetchgit {
    inherit rev;
    url = "https://github.com/netorcai/netorcai.git";
    sha256 = "0073f1vvkwi77dmbav77fj09wvpxhmhcbfiqzm34kyzdjq2k22wd";
  };

  goDeps = ./deps.nix;

  meta = {
    description = "A network orchestrator for artificial intelligence games";
    homepage = "https://github.com/netorcai/netorcai";
    license = stdenv.lib.licenses.gpl3;
    platforms = stdenv.lib.platforms.linux;
  };
}
