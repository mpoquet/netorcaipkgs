let
  pkgs = import
    (fetchTarball "https://github.com/NixOS/nixpkgs/archive/18.09.tar.gz") {};
  kapack = import
    ( fetchTarball "https://github.com/oar-team/kapack/archive/fe342846a8dfccc85077798357f9d7a9e889a8c7.tar.gz")
  { inherit pkgs; };
in

let
  # Add libraries to the scope of callPackage
  callPackage = pkgs.lib.callPackageWith (kapack // pkgs // pkgs.xlibs // self);

  self = rec {
    inherit pkgs;

    # Orchestrator
    netorcai = callPackage ./netorcai {};
    netorcai_dev = callPackage ./netorcai/dev.nix {};

    # Games
    hexabomb = callPackage ./hexabomb {};
    hexabomb_dev = callPackage ./hexabomb/dev.nix {};

    # Client libraries
    netorcai_client_cpp_dev = callPackage ./netorcai-client-cpp/dev.nix {};

    # Misc.
    rapidjson = callPackage ./rapidjson {};
    gtest = callPackage ./gtest {};
  };
in
  self
