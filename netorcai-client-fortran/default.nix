{ stdenv, fetchgit, gfortran, meson, ninja, pkgconfig, pythonPackages, zofu,
  doTests? false, netorcai_dev
}:

stdenv.mkDerivation rec {
  name = "netorcai-client-fortran-${version}";
  version = "0.1.0";

  src = fetchgit {
    rev = "v${version}";
    url = "https://github.com/netorcai/netorcai-client-fortran.git";
    sha256 = "0sm97afwpjn1k6smabcpwcz5965kmpzf1yik7h56xavbmg0zn0hn";
  };

  nativeBuildInputs = [gfortran meson ninja pkgconfig pythonPackages.gcovr];
  propagatedBuildInputs = [zofu];
  enableParallelBuilding = true;

  mesonFlags = [
    #"-Db_coverage=true"
  ];

  buildPhase = ''
    ninja
    ninja test
    #ninja coverage-text
  '';

  installPhase = ''
    ninja install
    #install -D meson-logs/coverage.txt $out/
  '';

  doCheck = doTests;
  meta = with stdenv.lib; {
    description = "FORTRAN version of the netorcai client library.";
    homepage    = "https://github.com/netorcai/netorcai-client-fortran";
    platforms   = platforms.unix;
  };
}
