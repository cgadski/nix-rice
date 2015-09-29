# things necessary to get the system running more or less
{ config, pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_4_2;

  # list not detected hardware
  imports = [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix> ];

  # hardware
  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "firewire_ohci" "usbhid" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  swapDevices = [ ];
  nix.maxJobs = 4;

  # bootloader and filesystem
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };
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
