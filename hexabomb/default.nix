{ stdenv, fetchgit, dmd, dub }:

stdenv.mkDerivation rec {
  name = "hexabomb-${version}";
  version = "0.1.0";

  src = fetchgit {
    rev = "v${version}";
    url = "https://github.com/netorcai/hexabomb.git";
    sha256 = "0wmw70acpm088im4sfm03l8bwl8g0dz90dci2zl8vcxib73bmd4m";
  };

  nativeBuildInputs = [ dmd dub ];
  enableParallelBuilding = true;

  buildPhase = ''
    dub fetch --cache=local --version=1.0.0 netorcai-client
    dub fetch --cache=local --version=0.6.1-b.6 docopt
    dmd -of=./hexabomb src/*.d netorcai-client-1.0.0/netorcai-client/src/netorcai/*.d docopt-0.6.1-b.6/docopt/source/*.d -fPIC -release -O
  '';

  installPhase = ''
    install -D ./hexabomb $out/bin/hexabomb
  '';

  meta = with stdenv.lib; {
    description = "Network multiplayer game for bots.";
    homepage    = "https://github.com/netorcai/hexabomb";
    platforms   = platforms.unix;
  };
}
