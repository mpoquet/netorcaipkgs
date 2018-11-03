{ stdenv, meson, ninja, rapidjson, pkgconfig, gtest
}:

stdenv.mkDerivation rec {
  name = "netorcai-client-cpp-${version}";
  version = "0.1.0-dev";

  src = fetchTarball "https://github.com/netorcai/netorcai-client-cpp/archive/master.tar.gz";

  nativeBuildInputs = [ meson ninja pkgconfig ];
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

  installPhase = ''
    # Generate coverage results
    find netorcai-client@sha -name '*.gcda' -exec gcov {} \;
    ninja install
    mkdir -p $out/coverage
    install -D *.gcov $out/coverage
  '';

  doCheck = true;
  meta = with stdenv.lib; {
    description = "C++ version of the netorcai client library.";
    homepage    = "https://github.com/netorcai/netorcai-client-cpp";
    platforms   = platforms.unix;
  };
}
