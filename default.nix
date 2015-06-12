{
  callRice = rice:
    {lib, config, pkgs, ...}:
      let 
        world = 
          import ./utilities/default.nix { inherit pkgs config lib; };
      in 
        ((buildRice rice) world).config;

  ############################# CONSTRUCTORS -> ELEMENTS ############################# 
  # Here we have the various constructors defined for the various elements.
  # They alone are fairly self-explanatory.
  #   terminal =
  #     makeTerminal { emulator = "tilda"; font = myFont; };  
  # For instance, defines 'terminal' to be a terminal element, constructed
  # with makeTerminal.

  makeRice = { customFiles, dm, wm }: 
  { 
    type = "rice";
    inherit customFiles dm wm; 
    assert dm.type == "dm";
    assert wm.type == "wm";
  };

  makeDM.slim = { theme, defaultUser }:
  {
    type = "dm";
    species = "slim";
    inherit theme defaultUser;
  };

  makeWM.i3 = { }:
  {
    type = "wm";
    species = "i3";
  }

  ############################# BUILDERS -> ACTUATORS ############################# 
  # In the necessary course that an element takes to contribute to the system
  # configuration, it is built into its respective actuator: an actuator
  # accepts as parameter a 'world' value that contains such things as the
  # system configuration and the package set, and returns a set with exactly
  # two elements: a set of configuration options, and a set of handles, 
  # which serve as return values for the actuator (a terminal may return
  # its binary file, for example).

  # These do not need to be called by the end user, as they are called via
  # the evaluation of callRice.

  buildRice = rice: world: with world;
    let
      myconfig = { 
        system.activationScripts = utils.distribute rice.customFiles; 
      }; 
    in 
      { 
        config = mkMerge 
          [(makeDM rice.dm).config (makeWM rice.wm).config myconfig];
        handles = { }; 
      }; 

  buildDM = dm: world: with world;
    let
      myconfig = 
        if dm.species = "slim" then
          {
            services.xserver.displayManager.slim = {
              enable = true;
              inherit theme defaultUser; 
            };
          } 
        else { };
    in
    { 
      config = mkMerge [ myconfig ];
      handles = { }; 
    };
}
