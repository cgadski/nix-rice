# call to the top-level rice expression
{config, lib, pkgs, ... }:
let
  stringToFile = contents: (x: x.out) (pkgs.writeTextFile {text = contents; name = "text";});
  inputs =
    {
      vimrc = stringToFile 
''
syntax on

set expandtab
set shiftwidth=2
set softtabstop=2

set autoindent
'';
      bashrc = stringToFile 
''
export test=testing
'';
    };
  homeFileOutputs = 
    filepath : map (prefix: prefix + filepath) ["/home/magneticduck/" "/root/"];

in

import /home/magneticduck/git/nix-rice/default.nix 
  {
    inherit config lib pkgs;
    # here are the rice-options that define what gets riced!
    rice-options = 
      { 
        nix-files = 
          [ 
            { input = inputs.vimrc; output = homeFileOutputs ".vimrc"; }
            { input = inputs.bashrc; output = homeFileOutputs ".bashrc"; }
          ];
      };
  }
