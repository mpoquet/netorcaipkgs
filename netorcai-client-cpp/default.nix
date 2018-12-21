{ stdenv, meson, ninja, nlohmann_json, sfml, pkgconfig, pythonPackages,
  doTests? false, netorcai_dev, gtest, psmisc,
  doCodeDoc? false, doxygen, gnutar
}:

stdenv.mkDerivation rec {
  name = "netorcai-client-cpp-${version}";
  version = "1.0.0";

  src = fetchTarball "https://github.com/netorcai/netorcai-client-cpp/archive/v${version}.tar.gz";

  nativeBuildInputs = [meson ninja pkgconfig pythonPackages.gcovr];
  propagatedBuildInputs = [nlohmann_json sfml] ++
    stdenv.lib.optionals doTests [gtest netorcai_dev psmisc] ++
    stdenv.lib.optionals doCodeDoc [doxygen gnutar];
  enableParallelBuilding = true;

  mesonFlags = [
    "-Db_coverage=true"
  ];

  buildPhase = ''
    ninja
    ninja test
    ninja coverage-text
    ninja doxygen-doc || true
  '';

  installPhase = ''
    ninja install
    install -D meson-logs/coverage.txt $out/

    if [ -d "doxygen-html" ]; then
      tar -czvf $out/doxygen-html.tar.gz doxygen-html
    fi
  '';

  doCheck = doTests;
  meta = with stdenv.lib; {
    description = "C++ version of the netorcai client library.";
    homepage    = "https://github.com/netorcai/netorcai-client-cpp";
    platforms   = platforms.unix;
  };
}
