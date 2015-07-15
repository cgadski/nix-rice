# this file describes how my system is, aside from its ricing
{ config, pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_4_0;
  
  # specify vim's basic configuration 
  environment.variables.EDITOR = "vim";
  environment.etc.vimrc = {
    text =
      ''
        syntax on
        set expandtab
        set shiftwidth=2
        set softtabstop=2
        set autoindent
        colorscheme desert
        set foldmethod=marker
        set nu
      ''; 
  };
  
  # here are the packages installed on my system
  environment.systemPackages = 
    let
      userpkgs = 
        with pkgs; [
          vim_configurable # vim with a wrapper to play nice with nixos
          wget dmenu nix-repl weechat 
          ranger transmission_gtk vlc
          unzip acpi file git
          arandr mumble gnome3.eog
          emacs libreoffice
          ffmpeg-full
          lilyterm firefoxWrapper
          xlibs.xbacklight acpi
          steam # ^^
        ];
      haskellpkgs = 
        with pkgs.haskellPackages; [ cabal-install ghc ];
    in
      userpkgs ++ haskellpkgs;

  users.extraUsers.magneticduck = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    uid = 1000;
  };

  virtualisation.docker.enable = true;

  services.xserver =
    { layout = "us"; xkbOptions = "eurosign:e"; 
      config =
        ''
          Section "InputClass"
            Identifier "Razer Abyssus"
            MatchProduct "Abyssus"
            Option "AccelerationProfile" "-1"
            Option "ConstantDeceleration" "5"
          EndSection
        '' ;
    };
}
