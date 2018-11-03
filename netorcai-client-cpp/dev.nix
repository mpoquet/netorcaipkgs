{ stdenv, meson, ninja, rapidjson, pkgconfig, gtest, pythonPackages,
}:

stdenv.mkDerivation rec {
  name = "netorcai-client-cpp-${version}";
  version = "0.1.0-dev";

  src = fetchTarball "https://github.com/netorcai/netorcai-client-cpp/archive/master.tar.gz";

  nativeBuildInputs = [ meson ninja pkgconfig pythonPackages.gcovr ];
  buildInputs = [ rapidjson gtest ];
  enableParallelBuilding = true;

  patchPhase = ''
    sed -i -E "s/'gtest'(.*) main: true,/'gtest_main'\1/" meson.build
  '';

  preConfigure = ''
    export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:${rapidjson}/lib/pkgconfig:${gtest}/lib/pkgconfig
  '';

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

  doCheck = true;
  meta = with stdenv.lib; {
    description = "C++ version of the netorcai client library.";
    homepage    = "https://github.com/netorcai/netorcai-client-cpp";
    platforms   = platforms.unix;
  };
}
