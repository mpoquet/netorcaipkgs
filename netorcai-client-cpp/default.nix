{ stdenv, fetchgit, meson, ninja, pkgconfig, pythonPackages,
  nlohmann_json, sfml,
  doTests? false, netorcai_dev, gtest, psmisc,
  doCodeDoc? false, doxygen, gnutar
}:

stdenv.mkDerivation rec {
  name = "netorcai-client-cpp-${version}";
  version = "2.0.0";

  src = fetchgit {
    rev = "v${version}";
    url = "https://github.com/netorcai/netorcai-client-cpp.git";
    sha256 = "0x9bpqq4j0953y43r09skpqb7j46456sxck6zcdnry6xlya41g8h";
  };

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
