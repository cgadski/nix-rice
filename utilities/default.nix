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
  };   

  nullActuator = {
    config = {};
    handles = {};
  };

  # utility function that builds an element into an actuator
  # with a builder if the element is not null, and otherwise
  # returns a nullActuator
  callElement = builder: element: 
    if isNull element then nullActuator else call (builder element);
})
