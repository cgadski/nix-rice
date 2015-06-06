# things necessary to get the system running more or less
{ config, pkgs, ... }:

{
  # these are the actual options I use on my T420 thinkpad

  # list not detected hardware
  imports = [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix> ];

  # hardware
  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "firewire_ohci" "usb_storage" ];
  boot.kernelModules = [ "kvm-intel" ];
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
