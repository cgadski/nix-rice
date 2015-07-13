# nix-rice

## what's ricing?

Ricing, in a restricted sense, is often used to describe the act of superficially modifying a UI to give it a better design, more suited to personal preference. r/unixporn is an example of a desktop ricing community. 

## what's nix-rice?

The nix-rice library is a wrapper over a subset of the nixos configuration system; particularly the part of that system concerned with parameters of concern to ricing. 

It aims to provide a method of ricing that is portable, fool-proof and easy to read, and distributable without worries regarding security or system breakage. Here is an example of the way in which one can define an (simple) ricing configuration in a single nix-language expression:

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

Imagine if posts on r/unixporn all came with their own rice expression so all you had to do to try them out would be to import them into your system configuration!

## glossary of terms

- world value
  - epistemically: represents everything an element of a ricing config could want to use.
  - practically: an internally referenced value constructed in utilities/default.nix, containg things like the nix package set and interal utility functions.
- element
  - epistemically: represents a part of a ricing configuration (a terminal or window manager).
  - practically: a function that, given the world value, constructs a set containing a 'type' attribute and some parameters (filepaths, numbers, other elements, you name it). The type attribute it used to implement a sort of trivial type-system; builders assert that their input element is of a certain type.
- constructor
  - epistemically: turns a set of user-specified parameters into an element; constructors are user-facing.
  - practically: a simple function that, given a set of necessary parameters, constructs an element.
- actuator
  - epistemically: the effectful result of an element.
  - practically: a function that, given the world value, returns a set containing a 'config' attribute and a 'handles' attribute, which represent the side-effects the actuator will have on the system configuration and the return values that it may produce (and be used to construct other actuators)respectively.
- builder
  - epistemicaly: a function that transforms an element into an actuator.
  - practically: a function that transforms an element into an actuator.
- a rice element
  - a top-level element of the nix-rice system; an entire ricing configuration.
- callRice
  - the entrypoint into the nix-rice library; builds a rice element with buildRice, supplies the result with the 'world' parameter and discards the 'handles' attribute that the actuator produces.

## description of general structure

callRice, the top-most entry point into nix-rice, accepts a rice element. The rice element is constructed with 'makeRice', taking as parameter a set of elements and values, the elements of which are constructed with other constructors of a similar pattern. Thus, the construction of a rice, similar to the construction of any other element, is hierarchal and fool-proof, an error being returned from a constructor if it is not given bad parameters.

For each type of element, there is a respective builder, which turns the element into an actuator; each builder calls builders for the child elements as well, the top-most builder being 'makeRice'.

The various configuration sets in play are merged with lib.mkMerge.

# the mission

  Is to go where no ricer has gone before; make a unified system for simple definition and fool-proof and deterministic deployment of ricing configurations.

  Thanks to everybody who showed interest in this, I'm going to go ahead and put some work into it.

# documentation of constructors

  Is available in MAKERICE.md in this directory.
