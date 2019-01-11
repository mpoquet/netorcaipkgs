{ stdenv, buildGoPackage, fetchgit }:

buildGoPackage rec {
  name = "netorcai-${version}";
  version = "1.2.0";
  rev = "v${version}";

  goPackagePath = "github.com/netorcai/netorcai";

  src = fetchgit {
    inherit rev;
    url = "https://github.com/netorcai/netorcai.git";
    sha256 = "0gazgwaziiv4a9bgvkqqiamnxg5q3sjgbjrlijl29f3h2xn7ddqf";
  };

  goDeps = ./deps.nix;

  meta = {
    description = "A network orchestrator for artificial intelligence games";
    homepage = "https://github.com/netorcai/netorcai";
    license = stdenv.lib.licenses.gpl3;
    platforms = stdenv.lib.platforms.linux;
  };
}
