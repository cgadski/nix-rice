########################### UTILITIES ############################
# this expression, given a set of containing nixpkgs, the nix library,
# and the system config, returns the "world" parameter over which 
# all elements are parameterized 

{pkgs, lib, config, ...}:

(f: let x = f x; in x)
(self: rec {
  world = self;
  call = x: x world;

  inherit pkgs config lib;

  utils = {
    distribute = import (./distribute.nix) {inherit pkgs;};

    # this takes an array of config sets and returns a single config set
    combineConfigs = myconfigs: 
      lib.foldl lib.recursiveUpdate {} myconfigs;
  };   
})
