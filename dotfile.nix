# the purpose of this expression is to define how a directory containing compiled dotfiles is deployed onto the system

# I guess I should take a few parameters. 
dotfiles: # the dotfiles derivation

{ config, pkgs ... }: 
  
{
  system.activationScripts = 
    {
      rice-dotfiles =
        '' echo "it appears that this works" > /home/outputfile ; ''
    }
}
