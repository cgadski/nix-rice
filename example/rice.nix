# this file describes my system's ricing configuration
# (using http://github.com/magneticduck/nix-rice)
{config, lib, pkgs, ... }:
with import /home/magneticduck/git/nix-rice/default.nix;

callRice {inherit config lib pkgs; user = "magneticduck";}
  (makeRice (world: with world; 
    let font = makeFont { name = "dejavu"; size = "12"; };
    # let font = makeFont { name = "inconsolata"; size = "10"; };
    in
    {
      wm = makeWM.i3 {
        inherit font;
        modkey = "Mod4";
        appearance = {
          windowBorder = 3;
          windowTitle = false;
        };
        # many more options can be added here
        term = makeTerm.lilyterm {
          browser = "firefox";
          email = "thunderbird";
          inherit font;
        };
      };
    }
  ))
