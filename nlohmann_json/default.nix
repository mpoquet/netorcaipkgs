{ stdenv, meson, ninja, pkgconfig }:

stdenv.mkDerivation rec {
  name = "nlohmann_json-${version}";
  version = "3.4.1-dev-pkgc";

  src = fetchTarball "https://github.com/nlohmann/json/tarball/ffe08983dd419c17aab44d9d02faaf5a372e0438";

  nativeBuildInputs = [ meson ninja pkgconfig ];

  doCheck = false;
  meta = with stdenv.lib; {
    description = "Header only C++ library for the JSON file format";
    homepage = https://github.com/nlohmann/json;
    license = licenses.mit;
    platforms = platforms.all;
  };
}
