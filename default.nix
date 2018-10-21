let
  pkgs = import
    (fetchTarball "https://github.com/NixOS/nixpkgs/archive/18.09.tar.gz") {};
  kapack = import
    ( fetchTarball "https://github.com/oar-team/kapack/archive/fe342846a8dfccc85077798357f9d7a9e889a8c7.tar.gz")
  { inherit pkgs; };
in

let
  # Add libraries to the scope of callPackage
  callPackage = pkgs.lib.callPackageWith (pkgs // pkgs.xlibs // kapack // self);

  self = rec {
    inherit pkgs;

    netorcai = callPackage ./netorcai {};
  };
in
  self
