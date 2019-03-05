{ hexabomb }:

hexabomb.overrideAttrs (oldAttrs: rec {
  name = "hexabomb-${version}";
  version = "1.2.0-dev";

  src = fetchTarball "https://github.com/netorcai/hexabomb/archive/master.tar.gz";
})
