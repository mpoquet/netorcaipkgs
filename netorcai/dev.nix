{ netorcai }:

netorcai.overrideAttrs (oldAttrs: rec {
  name = "netorcai-${version}";
  version = "1.2.0-dev";

  src = fetchTarball "https://github.com/netorcai/netorcai/archive/master.tar.gz";
})
