{ hexabomb }:

hexabomb.overrideAttrs (oldAttrs: rec {
  name = "hexabomb-${version}";
  version = "0.2.0-dev";

  src = fetchTarball "https://github.com/netorcai/hexabomb/archive/master.tar.gz";
})
