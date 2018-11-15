{ stdenv, fetchzip, meson, ninja, pkgconfig }:

stdenv.mkDerivation rec {
  name = "nlohmann_json-${version}";
  version = "3.4.0";

  src = fetchzip {
    url = "https://github.com/nlohmann/json/releases/download/v${version}/include.zip";
    sha256 = "1p7yasc3z0s9q181vj3pb7bwagjpljnvl6005h6fvli6zanz0zyw";
  };

  prePatch = ''
    # Nix unzips the archive too much.
    mkdir include
    mv nlohmann include/
  '';

  patches = [ ./add-meson.patch ];
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
