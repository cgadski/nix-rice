{pkgs, config, utilities, ...}:

let
  makeUtility = file: import file {inherit pkgs;};
in

rec {
  distribute = makeUtility ./distribute.nix;
  call = x: x { inherit pkgs config utilities;};


  # this takes an array of config sets and returns a single config set
  combineConfigs = configs: throw "how do I do this?";
}
