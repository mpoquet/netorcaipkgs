{ stdenv, buildGoPackage, fetchgit }:

buildGoPackage rec {
  name = "netorcai-${version}";
  version = "1.1.0";
  rev = "v${version}";

  goPackagePath = "github.com/netorcai/netorcai";

  src = fetchgit {
    inherit rev;
    url = "https://github.com/netorcai/netorcai.git";
    sha256 = "1mlfdxyz2j6jm321nnvivq6kjjicd44c62qv4kp6r3xihcciccwn";
  };

  goDeps = ./deps.nix;

  meta = {
    description = "A network orchestrator for artificial intelligence games";
    homepage = "https://github.com/netorcai/netorcai";
    license = stdenv.lib.licenses.gpl3;
    platforms = stdenv.lib.platforms.linux;
  };
}
