{
  ############################## BIG PICTURE ############################## 
  # The nix-rice library is a wrapper over a subset of the nixos configuration
  # system; particularly the part of that system concerned with parameters
  # of concern to ricing (the superficial configuration of the user interface).

  # Here, we define a system of modularly nester 'elements', which conceptually 
  # represent parts of the ricing configuration (display managers and their dotfiles,
  # terminals and their colorschemes), which contribute to a top-level element,
  # called a 'rice'. This element may contribute to a system configuration by 
  # being called with 'callRice' subsequently being imported into a branch of
  # configuration.nix

  # callRice:
    # this is the top-level function: calling it with a 'rice' element 
    # constructed with makeRice results in a configuration set parameterized 
    # over {lib, config, pkgs} which can be imported into configuration.nix
  callRice = rice:
    {lib, config, pkgs, ...}:
      let 
        world = 
          import ./utilities/default.nix { inherit pkgs config lib; };
      in 
        (world.call (buildRice rice).config;

  ############################# CONSTRUCTORS ############################# 
  # Here we have the various constructors defined for the various elements.
  # They alone are fairly self-explanatory.
  #   terminal =
  #     makeTerminal { emulator = "tilda"; font = myFont; };  
  # For instance, defines 'terminal' to be a terminal element, constructed
  # with makeTerminal.

  # makeRice:
    # constructs a 'rice' element
      # customFiles: a set of dotfiles to be distributed across the system
        # of the form: [{in = <input filepath>; out = [<output filepaths>];}]
      # dm: the dm (desktop manager) element
      # wm: the wm (window manager) element
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


  ############################# ACTUATORS ############################# 
  # In the necessary course that an element takes to contribute to the system
  # configuration, it is built into its respective actuator: an actuator
  # accepts as parameter a 'world' value that contains such things as the
  # system configuration and the package set, and returns a set with exactly
  # two elements: a set of configuration options, and a set of handles, 
  # which serve as return values for the actuator (a terminal may return
  # its binary file, for example).

  buildRice = rice: world: with world;
    let
      myconfig = { 
        system.activationScripts = utils.distribute rice.customFiles; 
      }; 
    in 
      { 
        config = mkMerge 
          [(call rice.dm).config (call rice.wm).config myconfig];
        handles = { }; 
      }; 

  makeDM.slim = dm: world: with world;
    let
      myconfig = {
        services.xserver.displayManager.slim = {
          enable = true;
          inherit theme defaultUser; 
        };
      }; 
    in
    { 
      config = mkMerge [ myconfig ];
      handles = { }; 
    };
}
