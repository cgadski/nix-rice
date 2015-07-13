########################### UTILITIES ############################
# this expression, given a set of containing nixpkgs, the nix library,
# and the system config, returns the "world" parameter over which 
# all elements are parameterized 

{pkgs, lib, config, user, ...}:

(f: let x = f x; in x)
(self: rec {
  world = self;

  call = x: if builtins.isFunction x then x world else x;

  nullActuator = { config = {}; handles = {}; };
  callElement = getBuilder: element: 
    let builder = call getBuilder; in
      if isNull element then nullActuator else builder element;

  mkBuilder = type: f: getElement: 
    let element = (call getElement); in
      assert element.type == type;
      f element;

  inherit pkgs config lib user;

  utils = {
    distribute = import (./distribute.nix) {inherit pkgs;};
  };   


})
