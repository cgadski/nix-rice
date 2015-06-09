{
  ############################## TOP LEVEL ############################## 

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
        (world.call rice).config;

  ############################# CONSTRUCTORS ############################# 
  # nix-rice's is based on 'elements', which represent pieces of a ricing 
  # configuration; they are functions that take a 'world' parameter, 
  # containing useful values values and some internal utilities, and result
  # in a set containing two elements: 'config', the configuration parameters
  # that the element intends to add to the system configuration, and
  # 'handles', a set of related return values that can be useful
  # to their parent elements (for instance, a terminal element may return
  # the path of the terminal's binary file)

  # makeRice:
    # constructs a 'rice' element
      # customFiles: a set of dotfiles to be distributed across the system
        # of the form: [{in = <input filepath>; out = [<output filepaths>];}]
      # dm: the dm (desktop manager) element
      # wm: the wm (window manager) element
  makeRice = { customFiles, dm, wm }: world: with world;
    let
      myconfig = { 
        system.activationScripts = utils.distribute customFiles; 
      }; 
    in 
      { config = utils.combineConfigs [(call dm).config myconfig];
        handles = { }; }; 

  # makeDM.slim:
    # constructs a dm element with the slim desktop manager
      # theme: the theme file to be used
        # pkgs.slimThemes.flat
      # defaultUser: the default user 
  makeDM.slim = { theme, defaultUser }: world: with world;
    let
      myconfig = {
        services.xserver.displayManager.slim = {
          enable = true;
          inherit theme defaultUser; 
        };
      }; 
    in
    { config = utils.combineConfigs [ myconfig ];
      handles = { }; };

  # makeDM.i3:
    # constructs a wm element with the i3 desktop manager
  makeWM.i3 = { }: world: with world;
    let
      myconfig = {
        services.xserver.windowManager.i3 = {
          enable = true;
        };
      }; in
    { config = utils.combineConfigs [ myconfig ];
      handles = { }; };
}
