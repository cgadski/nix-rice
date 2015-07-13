{config, lib, pkgs, ... }:
let
  nix-rice = import /home/magneticduck/git/nix-rice/default.nix;
  normalUser = "magneticduck";

  inputs = { vimrc = ./dotfiles/vimrc; };
  homeFileOutputs = 
    filepath : map (prefix: prefix + filepath) [("/home/" + normalUser + "/") "/root/"];

  myRice = with nix-rice; 
    makeRice {
      customFiles = 
        [ {input = inputs.vimrc; output = homeFileOutputs ".vimrc";} ] ;
      wm = makeWM.i3 { terminal = null; };
    };

in

nix-rice.callRice myRice { inherit config lib pkgs; }
