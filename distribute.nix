{ config, pkgs, ... }: 
files: 
with { inherit (pkgs.stdenv.lib) concatStrings; };

let
  logfile = "/etc/nix-files";
 
  unlines = x: concatStrings (map (y: y + "\n") x) ;
  activateFile = 
    x: concatStrings (map (destination: 
      "echo ${destination} >> ${logfile}; cat ${x.input} >> ${destination}; ") x.output);
in

{
  system.activationScripts = 
    {
      nix-rice = unlines 
        [ "rm -f $(cat ${logfile}); rm -f ${logfile}"
          (unlines (map activateFile files))
        ];
    };
}
