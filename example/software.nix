# things necessary to do work on the system, outside of ricing
{ config, pkgs, ... }:

{
  environment.variables.EDITOR = "vim";

  nixpkgs.config =
    { 
      allowUnfree = true;
      firefox = 
        { enableAdobeFlash = true; }; 
    };

  virtualisation.docker.enable = true;

  environment.systemPackages = 
    let
      userpkgs = 
        with pkgs; [
          wget vim dmenu firefoxWrapper nix-repl weechat 
          ranger transmission_gtk vlc
          unzip acpi file git
          arandr mumble gnome3.gedit gnome3.eog
          emacs libreoffice
          i3status ffmpeg
          lilyterm x11vnc
        ];
      haskellpkgs = 
        with pkgs; [ ];
    in
      userpkgs ++ haskellpkgs;

  users.extraUsers.magneticduck = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    uid = 1000;
  };

  services.xserver =
    { enable = true; layout = "us"; xkbOptions = "eurosign:e"; autorun = true;
      config =
        ''
          Section "InputClass"
            Identifier "Razer Abyssus"
            MatchProduct "Abyssus"
            Option "AccelerationProfile" "-1"
            Option "ConstantDeceleration" "5"
          EndSection
        '' ;
      windowManager = { i3.enable = true; };
    };
}
