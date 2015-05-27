{pkgs, config, ...}:
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
  homeFileOutputs = filepath : map (prefix: prefix + filepath) ["/home/magneticduck/" "/root/"];

in
    
(import (/home/magneticduck/git/nix-rice/distribute.nix) {inherit pkgs config;})
  [
    {output = homeFileOutputs ".vimrc"; input = inputs.vimrc;}
    {output = homeFileOutputs ".bashrc"; input = inputs.bashrc;}
  ]
