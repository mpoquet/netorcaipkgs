{ stdenv, fetchgit, meson, ninja, pkgconfig,
  netorcai_client_cpp, sfml, boost,
  doTests? false,
  doCodeDoc? false,
}:

stdenv.mkDerivation rec {
  name = "hexabomb-visu-${version}";
  version = "meh";

  src = fetchgit {
    rev = "04350d377600b0a051c363d248ff8a13e4230b97";
    url = "https://github.com/netorcai/hexabomb-visu.git";
    sha256 = "06rvbsgzs7cv6pai18p1hrd50vi6zr41bm57zpdc0iydv5r5h6zv";
  };

  nativeBuildInputs = [meson ninja pkgconfig];
  buildInputs = [netorcai_client_cpp sfml boost];
  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "SFML visualization client for hexabomb.";
    homepage    = "https://github.com/netorcai/hexabomb-visu";
    platforms   = platforms.unix;
  };
}
