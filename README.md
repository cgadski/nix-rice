# nix-rice

## What's Ricing?

Ricing, in a restricted sense, is often used to describe the act of superficially modifying a UI to give it a better design, more suited to personal preference. r/unixporn is an example of a desktop ricing community. The purpose of the nix-rice project is to use nix to facilitate the development and distribution of riced configurations, using the excellent nixos / nix system.

## Motavation behind this project

Nixos has let us manage a lot of aspects of our systems in a pure and replicatable way, but areas of particular interest to ricers, such as system-wide dotfile management, have gone mostly untouched. This project's goal is to add a layer on nixos that facilitates ricing and sharing of ricing configs. One major step that we must pass to get there is satisfactory Adotfile management, and that is the mission currently in progress.

## Outline of what is expected of a "dotfile management" system

The principle action of such a system is to give tools and elements that tie into the nixpkgs/nixos structure the ability to define configuration files in a clear and efficent way, causing files to be created on various points of the filesystem, such as hidden directories in user $HOMEs. The system should have a few properties that distinguish it from a simplistic "echo change >> /home/user/.configfile":

  - It acts in a pure way, uninfluenced by previous generations and their associated dotfiles; a set of invocations of the dotfile system always produce the same result. This also means that in the absence of any invocations of the dotfile system to a particular dotfile results in the deletion of any that dotfile.
  - It makes use of a system like augeas to intelligently manage multiple invocations of different properties in the same dotfile. 

## Who's going to make it?

I'll take the first few steps and then hopefully people will stop me before I get myself into too much trouble.

