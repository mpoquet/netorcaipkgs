{ stdenv, fetchgit, gfortran, meson, ninja, pkgconfig }:

stdenv.mkDerivation rec {
  name = "zofu-${version}";
  version = "0.2.0-unreleased";

  src = fetchgit {
    rev = "fdb68c652bdefaf8192e69e412ff97123b42ec63";
    url = "https://github.com/acroucher/zofu";
    sha256 = "1gbg7qz4qlalm266wwyalpdiablkjn439vrwx9x6lvp3mvsx41w8";
  };

  nativeBuildInputs = [gfortran meson ninja pkgconfig];
  enableParallelBuilding = true;

  buildPhase = ''
    ninja
  '';

  installPhase = ''
    ninja install
  '';

  meta = with stdenv.lib; {
    description = "An Object-oriented Fortran Unit-testing framework.";
    homepage    = "https://github.com/acroucher/zofu";
    platforms   = platforms.unix;
  };
}
