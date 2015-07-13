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
  makeTerm.lilyterm = opts:
    world: { type = "term"; species = "lilyterm"; } // (world.call opts);
  makeFont.dejavu = opts:
    world: { type = "font"; species = "dejavu"; } // (world.call opts);

## BUILDERS return ACTUATORS ##
  # buildRice {{{
  buildRice = world: with world; 
    mkBuilder "rice" (
      rice@{
        customFiles ? [], 
        wm ? null, ...}:
      let
        wmAct = callElement buildWM wm;
        myconfig = { 
          system.activationScripts = utils.distribute customFiles; 
        }; 
      in 
        { 
          config = lib.mkMerge [wmAct.config myconfig];
          handles = { }; 
        }
    ); # haha a frowny face
  # }}}

  # buildWM {{{
  buildWM = world: with world;
    mkBuilder "wm" (wm@{species ? "i3", ...}:
      if wm.species == "i3" then
        callElement buildWMs.i3 wm
      else throw ("unknown wm species " + wm.species)
    );
  # }}}

  # buildWMs.i3 {{{
  buildWMs.i3 = world: with world;
    mkBuilder "wm" (
      wm@{
        term ? null, 
        modkey ? "Mod4", ...}: 
      let
        termAct = callElement buildTerm term;
        myconfig =
          {
            services.xserver = { 
              displayManager.slim.enable = true;
              windowManager.i3.enable = true; 
              windowManager.i3.configFile = 
                pkgs.writeTextFile { 
                  name = "config"; 
                  text = import ./dotfiles/i3.nix {
                    inherit modkey;
                    term = 
                      if isNull term then "xterm" else 
                        termAct.handles.out;
                  };
                };
              autorun = true; enable = true; 
            };
          };
      in
        { 
          config = lib.mkMerge [myconfig termAct.config];
          handles = {}; 
        }
    );
  # }}}

  # buildTerm  {{{
  buildTerm = world: with world;
    mkBuilder "term" (term@{species ? "lilyterm", ...}:
      if term.species == "lilyterm" then
        callElement buildTerms.lilyterm term
      else throw ("unknown term species " + term.species)
    );
  # }}}

  # buildWMs.i3 {{{
  buildTerms.lilyterm = world: with world;
    mkBuilder "term" (
      term@{
        font ? "Monospace 12", 
        browser ? "firefox", 
        email ? "thunderbird", ...}: 
      let
        myconfig = { };
        lilyterm-config =
          pkgs.writeTextFile {
            name = "lilyterm.config"; 
            text = import ./dotfiles/lilyterm.nix 
              {inherit font browser email;};
          };
      in
        { 
          config = myconfig;
          handles = { 
            out = 
              pkgs.writeScript "lilyterm" ''
                ${pkgs.lilyterm}/bin/lilyterm -u ${lilyterm-config}
              ''; 
          }; 
        }
    );
  # }}}

  # buildFont {{{ 
  buildFont = world: with world;
    mkBuilder "font" (font@{species ? "dejavu", ...}:
      if font.species == "dejavu" then
        callElement buildFonts.dejavu font
      else throw ("unknown font species " ++ font.species)
    );
  # }}}

  # buildFonts.dejavu {{{
  buildFonts.dejavu = world: with world;
    mkBuilder "font" (font@{size ? "12", ...}:
      let
        myconfig = {
          fonts = {
            enableFontDir = true;
            enableGhostscriptFonts = true;
            fonts = with pkgs; [
              dejavu_fonts
            ];
          };
        };
      in
        { 
          config = myconfig;
          handles = {
            name = "Dejavu ${size}";
          };
        }
    );
  # }}}
})
