nix-rice: with nix-rice;
{ 
  simple-i3-and-vim = 
    makeRice (world: with world; 
      let
        inputs = { vimrc = ./precooked-dots/vimrc; };
        homeFileOutputs = 
          filepath : map (prefix: prefix + filepath) [("/home/" + user + "/") "/root/"]; 
      in
      {
        customFiles = 
          [ {input = inputs.vimrc; output = homeFileOutputs ".vimrc";}];
        wm = makeWM.i3 {
          modkey = "Mod4";
          term = 
            makeTerm.i3 {
                  
            };
        };
      }
    );
}
