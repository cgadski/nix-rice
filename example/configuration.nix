# the top-level configuration set
{ config, pkgs, ... }:

{
  imports = [ ./boot.nix ./software.nix ./rice.nix];
  nixpkgs.config = import ./nixpkgs.nix;
}
