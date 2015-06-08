{config, lib, pkgs, ... }:
let
  nix-rice = import /home/magneticduck/git/nix-rice/default.nix;
  normalUser = "magneticduck";

  inputs = { vimrc = ./dotfiles/vimrc; };
  homeFileOutputs = 
    filepath : map (prefix: prefix + filepath) [("/home/" + normalUser + "/") "/root/"];
in

nix-rice.callRice 
  { inherit config pkgs; }
  (with nix-rice; 

  makeRice {
    customFiles = 
      [ {input = inputs.vimrc; output = homeFileOutputs ".vimrc";} ] ;
    wm = makeWM.i3 {};
    dm = makeDM.slim { 
      theme = null;
      defaultUser = null;
    };
  })
