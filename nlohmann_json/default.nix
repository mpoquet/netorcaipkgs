{ stdenv, fetchurl, meson, ninja, pkgconfig }:

stdenv.mkDerivation rec {
  name = "nlohmann_json-${version}";
  version = "3.4.0";

  src = fetchurl {
    url = "https://github.com/nlohmann/json/releases/download/v${version}/json.hpp";
    sha256 = "63da6d1f22b2a7bb9e4ff7d6b255cf691a161ff49532dcc45d398a53e295835f";
  };

  # Not unpacking a tarball here, just copying a single file.
  unpackPhase = ''
    cp ${src} ./json.hpp
  '';

  patches = [ ./make-buildable-and-installable-from-meson.patch ];
  postPatch = ''
    # Update version in meson description if needed
    sed -i -E "s/3.4.0/${version}/" meson.build
  '';

  nativeBuildInputs = [ meson ninja pkgconfig ];

  doCheck = false;
  meta = with stdenv.lib; {
    description = "Header only C++ library for the JSON file format";
    homepage = https://github.com/nlohmann/json;
    license = licenses.mit;
    platforms = platforms.all;
  };
}
