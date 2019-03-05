{ stdenv, fetchgit, dmd, dub }:

stdenv.mkDerivation rec {
  name = "hexabomb-${version}";
  version = "1.1.0";

  src = fetchgit {
    rev = "v${version}";
    url = "https://github.com/netorcai/hexabomb.git";
    sha256 = "1hc6k7472r0craldipqz5hb158i0rr009lc598xbnk7xbpvy2lc7";
  };

  nativeBuildInputs = [ dmd dub ];
  enableParallelBuilding = true;

  buildPhase = ''
    dub fetch --cache=local --version=2.0.0 netorcai-client
    dub fetch --cache=local --version=0.6.1-b.6 docopt
    dmd -of=./hexabomb src/*.d netorcai-client-2.0.0/netorcai-client/src/netorcai/*.d docopt-0.6.1-b.6/docopt/source/*.d -fPIC -release -O
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
