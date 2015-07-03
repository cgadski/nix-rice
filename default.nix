rec {
  callRice = rice:
    {lib, config, pkgs, ...}:
      let 
        world = 
          import ./utilities/default.nix { inherit pkgs config lib; };
      in 
        (world.call (buildRice rice)).config;

  ############################# CONSTRUCTORS -> ELEMENTS ############################# 
  # Here we have the various constructors defined for the various elements.
  # They alone are fairly self-explanatory.
  #   terminal =
  #     makeTerminal { emulator = "tilda"; font = myFont; };  
  # For instance, defines 'terminal' to be a terminal element, constructed
  # with makeTerminal.

  makeRice = { customFiles, wm }: 
    assert wm.type == "wm";
  { 
    type = "rice";
    inherit customFiles wm; 
  };

  makeWM.i3 = { }:
  { type = "wm";
    species = "i3";
  };

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

  # buildRice {{{
  buildRice = {type, customFiles, wm}: world: with world;
    assert type == "rice";

    let
      myconfig = { 
        system.activationScripts = utils.distribute customFiles; 
      }; 
      wmActuator = world.call (buildWM wm);
    in 
      { config = lib.mkMerge [wmActuator.config myconfig];
        handles = { }; 
      }; 
  # }}}

  # buildWM {{{
  buildWM = wm@{type, species}: world: with world;
    assert type == "wm";

    if species == "i3" then
      world.call (buildWMs.i3 wm)
    else throw "bad species";
  # }}}

  # buildWMs.i3 {{{
  buildWMs.i3 = {type, species}: world: with world;
    assert type == "wm"; assert species == "i3";

    let
      myconfig =
        {
          services.xserver.displayManager.slim = { enable = true; };
          services.xserver.windowManager.i3 = { enable = true; };
        };
    in
      { config = myconfig;
        handles = {}; };
  # }}}
}
