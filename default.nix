let fix = f: let x = f x; in x; in fix (self: with self; {
## PRECOOKED RICE ;) ##
  precooked = import ./precooked.nix self;
  
## CALLRICE returns a CONFIGURATION SET ##
  callRice = rice:
    {lib, config, pkgs, user, ...}:
      let 
        world = import ./utilities/default.nix 
          { inherit pkgs config lib user; };
      in 
        ((world.call buildRice) rice).config;

## CONSTRUCTORS return ELEMENTS ##
  makeRice = opts: 
    world: { type = "rice"; } // (world.call opts);

  makeWM.i3 = opts: 
    world: { type = "wm"; species = "i3"; } // (world.call opts);

## BUILDERS return ACTUATORS ##
  # buildRice {{{
  buildRice = world: with world; 
    mkBuilder "rice" (rice@{customFiles ? [], wm ? null, ...}:
      let
        wmActuator = callElement buildWM wm;
        myconfig = { 
          system.activationScripts = utils.distribute customFiles; 
        }; 
      in 
        { 
          config = lib.mkMerge [wmActuator.config myconfig];
          handles = { }; 
        }
    ); 
  # }}}

  # buildWM {{{
  buildWM = world: with world;
    mkBuilder "wm" (wm@{species ? "i3", ...}:
      if wm.species == "i3" then
        callElement buildWMs.i3 wm
      else throw "bad species"
    );
  # }}}

  # buildWMs.i3 {{{
  buildWMs.i3 = world: with world;
    mkBuilder "wm" (wm@{terminal ? null, modkey ? null, ...}: 
      let
        myconfig =
          {
            services.xserver = { 
              displayManager.slim.enable = true;
              windowManager.i3.enable = true; 
              autorun = true; enable = true; 
            };
          };
      in
        { config = myconfig;
          handles = {}; }
    );
  # }}}
})
