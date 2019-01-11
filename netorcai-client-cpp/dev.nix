{ netorcai_client_cpp,
  doTests? false,
  doCodeDoc? false
}:

(netorcai_client_cpp.override{ inherit doTests; inherit doCodeDoc; }).overrideAttrs (oldAttrs: rec {
  name = "netorcai-client-cpp-${version}";
  version = "1.2.0-dev";

  src = fetchTarball "https://github.com/netorcai/netorcai-client-cpp/archive/master.tar.gz";
})
