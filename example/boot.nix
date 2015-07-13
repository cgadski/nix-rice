# things necessary to get the system running more or less
{ config, pkgs, ... }:

{
  # list not detected hardware
  imports = [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix> ];

  # hardware
  boot.initrd.availableKernelModules = [ "xhci_hcd" "ehci_pci" "ahci" "usb_storage" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.blacklistedKernelModules = [ "snd_pcsp" ];
  boot.extraModprobeConfig = ''
    options snd_hda_intel enable=0,1
  '';
  boot.extraModulePackages = [ ];
  swapDevices = [ ];
  nix.maxJobs = 4;

  # bootloader and filesystem
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  fileSystems."/".device = "/dev/disk/by-label/nixos";

  # networking
  networking.hostName = "nixos";
  networking.connman.enable = true;

  # internationalisation
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };
}
