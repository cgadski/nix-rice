{pkgs, config, utilities, ...}:

let
  makeUtility = file: import file {inherit pkgs;};
in

{
  distribute = makeUtility ./distribute.nix;
  call = x: x { inherit pkgs config utilities;};
}
