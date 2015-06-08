{ pkgs, ... }: 
nix-files:

let
  inherit (pkgs.stdenv.lib) concatStrings; 

  files = nix-files;

  logfile = "/etc/nix-files";
 
  unlines = x: concatStrings (map (y: y + "\n") x) ;
  activateFile = 
    x: concatStrings (map (destination: 
      ''echo ${destination} >> ${logfile}; mkdir -p ${destination}; 
      rmdir ${destination}; cat ${x.input} >> ${destination};'') x.output);
in

# system.activationScripts
{
  nix-rice = unlines 
    [ "rm -f $(cat ${logfile}); rm -f ${logfile}"
      (unlines (map activateFile files))
    ];
}
