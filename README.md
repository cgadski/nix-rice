# nix-rice
Ricing, in a restricted sense, is often used to describe the act of superficially modifying a UI to give it a better design, more suited to personal preference. r/unixporn is an example of a desktop ricing community. The purpose of the nix-rice project is to use nix to facilitate the development and distribution of riced configurations, using the excellent nixos / nix system.

## top-level structure
The configuration.nix should reference rice.nix of this repository in its imports definition like so:


    (framework and style added to scope)

    imports = 
      [ (import (path_to_repository)/rice.nix) {inherit framework style;} 
      ... ]

rice.nix is controlled exclusively through the framework and style parameters; their meanings are as follows:

 - 'elements' is a set with some crucial elements, like the desktop manager, the window manager, the default terminal, and a slot to specity an optional list of things you want installed on the system that are directly related to the configuration. Conky would be an example of this last category. Declarations in this set are meant to be kept to minimal (configurations are not specified here).
 - 'style' is a set that specifies styles and configurations which are applied to the elements.  They can be cross-cutting, such as a color theme or a font, or they can be targeted at particular elements, in the case of a key-binding configuration for a terminal emulator.

## elements documentation

So, like. Uhh. I'll get to this in a minute.
