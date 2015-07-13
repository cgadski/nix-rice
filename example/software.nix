# things necessary to do work on the system, outside of ricing
{ config, pkgs, ... }:

{
  environment.variables.EDITOR = "vim";

  boot.kernelPackages = pkgs.linuxPackages_4_0;

  nixpkgs.config = {
    firefox.enableAdobeFlash = true;
  };

  environment.systemPackages = 
    let
      userpkgs = 
        with pkgs; [
          wget vim dmenu nix-repl weechat 
          ranger transmission_gtk vlc
          unzip acpi file git
          arandr mumble gnome3.eog
          emacs libreoffice
          ffmpeg-full
          lilyterm firefoxWrapper
          xlibs.xbacklight acpi
          steam
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
