# nix-rice

## What's Ricing?

Ricing, in a restricted sense, is often used to describe the act of superficially modifying a UI to give it a better design, more suited to personal preference. r/unixporn is an example of a desktop ricing community. 

## What is this Project?

The purpose of the nix-rice project is to use nix to develop and deploy linux desktop ricing configurations, and solve related issues and add necessary features to the nixos system in the process.

It acts, essentially, as a small wrapper to a part of the nixos configuration system; it adds a few features and seperates the particular aspects of concern to ricers (desktop managers, terminal color schemes) from the rest of the system, presenting a tidy modular interface for them. 

## How do I use this project as an end-user?

Import a file like example/rice.nix into your configuration.nix, and adjust makeRice accordingly. 

## What is the structure of this project?

The project is defined in terms of 'elements', functional parts of the graphic system. The top-most element, the 'rice', is constructed with makeRice, and takes a set of custom dotfiles, a desktop manager element, and a window manager element; the desktop manager and window manager, in turn, are constructed with constructors in the makeDM and makeWM sets, each element evoking a different window manager or desktop manager.

This hierarchy continues down until there are no elements to mention, branching over things like color schemes, terminal fonts, desktop backgrounds, status indicators, and the like.

# Why am I not just using configuration.nix?

Nix-rice is a simpler, more portable and compact way of ricing. You can send it to other people, it's easily readable, and of course deterministic. Doesn't this look cool?

    makeRice {
      customFiles = [{input = ./vimrc; output = userFile ".vimrc";}];
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
  
## Wow, it can do all that?

Uh. I'm getting there.
