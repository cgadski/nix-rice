# nix-rice

## What's Ricing?

Ricing, in a restricted sense, is often used to describe the act of superficially modifying a UI to give it a better design, more suited to personal preference. r/unixporn is an example of a desktop ricing community. 

## Why am I not just using configuration.nix for ricing?

Nix-rice is a simpler, more portable and compact way of ricing. It forms a small wrapper over a part of the nixos configuration system, adding some necessary features (like dotfile management), reorganising structure, and seperating ricing from the rest of the system configuration. Here's an example of a ricing:

    makeRice {
      customFiles = [{input = ./vimrc; output = userFile ".vimrc";}];
        # yes, that is deterministic dotfile management!
      dm = makeDM.slim {
        background = ./backgrounds/water-drops.jpg;
        defaultUser = normalUser;
      }
      wm = makeWM.i3 rec {
        modkey = "Mod4";
        appearance = 
          { windowHeader = false; windowBorder = 3; };
        font = terminal.font;
        terminal = makeTerminal.tilda {
          transparence = 0.3;
          font = makeFont.powerline {
            baseFont = "dejavu";
          };
        };
      };
    }

Imagine if posts on r/unixporn all came with their own rice expression so all you have to do to try them out is import them into your system configuration!

## How do I use / contribute to it?

example/rice.nix is a usage case, and there is documentation in the source code.

## TODO list

- Fix the combineConfigs function in utilities/default.nix
- Use options to build the files sent to utils.distribute, the dotfile management activation script (so that elements can define their own dotfiles via a an element in config)
- Add constructors
