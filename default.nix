{rice-options, config, pkgs, ... }:

let
  utilities = (import ./utilities/default.nix) {inherit pkgs rice-options;};
in

{
  system.activationScripts = utilities.distribute rice-options;
}
