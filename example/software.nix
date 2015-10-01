# this file describes how my system is, aside from its ricing
{ config, pkgs, ... }:

let
  customEditors =
    import /home/magneticduck/git/editors {nixpkgs = pkgs;};

  my_vim = 
    pkgs.vim_configurable.customize { 
      name = "vim";
      vimrcConfig.customRC =  
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
      vimrcConfig.vam.pluginDictionaries = [
      ];
    };
  in
{
  hardware.opengl.driSupport32Bit = true;

  nixpkgs.config.firefox = {
    enableAdobeFlash = true;
  };

  
  # specify vim's basic configuration 
  environment.variables.EDITOR = "vim";
  environment.variables.NIX_GHC = "/run/current-system/sw/bin/ghc";
  environment.variables.NIX_GHCPKG = "/run/current-system/sw/bin/ghc-pkg";
  environment.variables.NIX_GHC_DOCDIR = "/run/current-system/sw/share/doc/ghc/html";
  environment.variables.NIX_GHC_LIBDIR = "/run/current-system/sw/lib/ghc-7.10.2";
  
  # here are the packages installed on my system
  environment.systemPackages = 
    let
      userpkgs = 
        with pkgs; [
          my_vim # vim with a wrapper to play nice with nixos
          atom skype
          wget dmenu nix-repl weechat 
          ranger transmission_gtk vlc
          unzip acpi file git
          arandr mumble gnome3.eog
          emacs libreoffice
          ffmpeg-full
          lilyterm firefoxWrapper
          xlibs.xbacklight acpi
          steam # ^^
          postgresql

          # userful for dev
          gcc zlib 
        ];
      myGhc = with pkgs.haskellPackages;
        ghcWithPackages(p: 
          [ p.ghc-mod p.hdevtools ] # p.ncurses p.lens p.aeson p.text p.haskell-src-exts p.haddock-api ]
        );
      haskellpkgs =  
        with pkgs.haskellPackages; [ 
          cabal-install myGhc stylish-haskell cabal2nix 
        ];
      editors =
        with customEditors; [
          sublime
        ];
    in
      userpkgs ++ haskellpkgs ++ editors;

  users.extraUsers.magneticduck = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    uid = 1000;
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "devicemapper";

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
