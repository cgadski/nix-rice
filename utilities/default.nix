{pkgs, config, utilities, ...}:

let
  makeUtility = file: import file {inherit pkgs;};
  lib = pkgs.stdenv.lib;
in

rec {
  distribute = makeUtility ./distribute.nix;
  call = x: x { inherit pkgs config utilities;};

  # this takes an array of config sets and returns a single config set
  combineConfigs = configs: 
  # an infinite recursion is encountered here: why?
    lib.foldl lib.recursiveUpdate {} [];
}
