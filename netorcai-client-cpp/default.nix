{ stdenv, fetchgit, meson, ninja, pkgconfig, pythonPackages,
  nlohmann_json, sfml,
  doTests? false, netorcai_dev, gtest, psmisc,
  doCodeDoc? false, doxygen, gnutar
}:

stdenv.mkDerivation rec {
  name = "netorcai-client-cpp-${version}";
  version = "1.1.0";

  src = fetchgit {
    rev = "v${version}";
    url = "https://github.com/netorcai/netorcai-client-cpp.git";
    sha256 = "1vg6dka6wafnx29wx03b55pp3ld74vlxjhhi6csj3s39v3ciydhl";
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
