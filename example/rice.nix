{config, lib, pkgs, ... }:
let
  nix-rice = import /home/magneticduck/git/nix-rice/default.nix;
in

nix-rice.callRice nix-rice.precooked.simple-i3-and-vim
  { inherit config lib pkgs; user = "magneticduck"; }
