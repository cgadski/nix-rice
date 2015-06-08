{
  callRice = { config, pkgs, ...}: rice:
    rice
      rec { inherit config pkgs;
        utilities = import ./utilities/default.nix {inherit config pkgs utilities;}; # utilities is passed to itself to define the "call" utility
      };
    
  makeRice = { customFiles, dm, wm }:
    { pkgs, config, utilities, ...}:

    let
      myconfig = { 
        system.activationScripts = utilities.distribute customFiles; 
      }; in
    {
      config = utilities.combineConfigs [dm myconfig];
    }; 

  makeDM.slim = { theme, defaultUser }:
    { pkgs, config, utilities, ...}:
    let
      myconfig = {
        services.xserver.displayManager.slim = {
          enable = true;
          inherit theme defaultUser; 
        };
      }; in
    {
      config = utilities.combineConfigs [ myconfig ];
      handles = { };
    };
  
  makeWM.i3 = { }:
    { pkgs, config, utilities, ...}:
    let
      myconfig = {
        services.xserver.windowManager.i3 = {
          enable = true;
        };
      }; in
    {
      config = utilities.combineConfigs [ myconfig ];
      handles = { };
    };
}
