nix-rice: with nix-rice;
{ 
  simple-i3-and-vim = 
    makeRice (world: with world; 
      let
        font = makeFont { name = "dejavu"; size = "12"; };
      in
      {
        wm = makeWM.i3 {
          inherit font;
          modkey = "Mod4";
          term = makeTerm.lilyterm {
            browser = "firefox";
            email = "thunderbird";
            inherit font;
          };
        };
      }
    );
}
