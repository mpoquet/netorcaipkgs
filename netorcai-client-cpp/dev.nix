{ stdenv, meson, ninja, nlohmann_json_pkgc, sfml, pkgconfig, pythonPackages,
  doTests? false, netorcai_dev, gtest, psmisc
}:

stdenv.mkDerivation rec {
  name = "netorcai-client-cpp-${version}";
  version = "0.1.0-dev";

  src = fetchTarball "https://github.com/netorcai/netorcai-client-cpp/archive/master.tar.gz";

  nativeBuildInputs = [ meson ninja pkgconfig pythonPackages.gcovr ];
  buildInputs = [ nlohmann_json_pkgc sfml ] ++
    stdenv.lib.optionals doTests [gtest netorcai_dev psmisc];
  enableParallelBuilding = true;

  mesonFlags = [
    "-Db_coverage=true"
  ];

  buildPhase = ''
    ninja
    ninja test
    ninja coverage-text
  '';

  installPhase = ''
    ninja install
    install -D meson-logs/coverage.txt $out/
  '';

  doCheck = doTests;
  meta = with stdenv.lib; {
    description = "C++ version of the netorcai client library.";
    homepage    = "https://github.com/netorcai/netorcai-client-cpp";
    platforms   = platforms.unix;
  };
}
