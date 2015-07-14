nix-rice: with nix-rice;
{ 
  simple-i3-and-vim = 
    makeRice (world: with world; 
      let
        inputs = { vimrc = ./precooked-dots/vimrc; };
        homeFileOutputs = 
          filepath : map (prefix: prefix + filepath) 
            [("/home/" + user + "/") "/root/"]; 
        font = makeFont {
          name = "dejavu";
          size = "12";
        };
      in
      {
        customFiles = 
          [ {input = inputs.vimrc; output = homeFileOutputs ".vimrc";}];
        
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
