# These are input variables of the main repository.
# Syntax is `variable ? default_value [, ...]`.
# Default values can be overriden with the --arg command-line argument
# (man nix-env or https://nixos.org/nix/manual/#sec-common-options)
{
  pkgs ? import
    (fetchTarball "https://github.com/NixOS/nixpkgs/archive/19.09.tar.gz") {},
  kapack ? import
    ( fetchTarball "https://github.com/oar-team/kapack/archive/8f56dcf1f4f43bda71449d2d2f9d4e5450be247c.tar.gz")
  { inherit pkgs; },
  doTests ? false,
  doCodeDoc ? true
}:
let
  # Add libraries to the scope of callPackage
  callPackage = pkgs.lib.callPackageWith (kapack // pkgs // pkgs.xlibs // self);

  # The list of packages starts here.
  self = rec {
    inherit pkgs;

    # Orchestrator
    netorcai = callPackage ./netorcai {};
    netorcai_dev = callPackage ./netorcai/dev.nix {};

    # Games
    hexabomb = callPackage ./hexabomb {};
    hexabomb_dev = callPackage ./hexabomb/dev.nix {};

    # Client libraries
    netorcai_client_cpp = callPackage ./netorcai-client-cpp
      { inherit doTests; inherit doCodeDoc; };
    netorcai_client_cpp_dev = callPackage ./netorcai-client-cpp/dev.nix
      { inherit doTests; inherit doCodeDoc; };
    netorcai_client_fortran = callPackage ./netorcai-client-fortran
      { inherit doTests; };

    # Visualizations
    hexabomb_visu = callPackage ./hexabomb-visu {};
    hexabomb_visu_dev = callPackage ./hexabomb-visu/dev.nix {};

    # Misc.
    rapidjson = callPackage ./rapidjson {};
    gtest = callPackage ./gtest {};
    nlohmann_json = callPackage ./nlohmann_json {};
    zofu = callPackage ./zofu {};
    serverize = callPackage ./serverize/Cargo.nix {};
  };
in
  self
