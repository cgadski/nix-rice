{pkgs, rice-options, ...}:

let
  callPart = file: rice-options: import file {inherit pkgs rice-options;};
in

{
  distribute = callPart ./distribute/default.nix;
}
