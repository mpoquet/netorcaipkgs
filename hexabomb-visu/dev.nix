{ hexabomb_visu,
  doTests? false,
  doCodeDoc? false
}:

(hexabomb_visu.override{ inherit doTests; inherit doCodeDoc; }).overrideAttrs (oldAttrs: rec {
  name = "hexabomb-visu-${version}";
  version = "meh-dev";

  src = fetchTarball "https://github.com/netorcai/hexabomb-visu/archive/master.tar.gz";
})
