{
  callRice = { config, pkgs, ...}: rice:
    rice
      rec { inherit config pkgs;
        utilities = import ./utilities/default.nix {inherit config pkgs utilities;}; # utilities is passed to itself to define the "call" utility
      };
    
  makeRice = { customFiles, dm, wm }:
    { pkgs, config, utilities, ...}:
    {
      system.activationScripts = utilities.distribute customFiles;
    } // (utilities.call dm).config; ## work in progress ofc

  makeDM.slim = { theme, defaultUser }:
    { pkgs, config, utilities, ...}:
    {
      config = {
        services.xserver.displayManager.slim = {
          enable = true;
          inherit theme defaultUser;
        };
      };
      handles = { };
    };
  
  makeWM.i3 = { }:
    { pkgs, config, utilities, ...}:
    {
      config = {
        services.xserver.windowManager.i3 = {
          enable = true;
        };
      };
      handles = { };
    };
    
  
}
