# this is the top-level configuration set
{ config, pkgs, ... }:

{
  imports = [ ./boot.nix ./software.nix ./rice.nix];
}
