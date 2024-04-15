{ config, lib, pkgs, modulesPath, ... }:
{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-label/ROOT";
      fsType = "btrfs";
      options = [
        "noatime"
        "nodiratime"
        "discard"
      ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
      options = [ "rw" "fmask=0022" "dmask=0022" "noatime" ];
    };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-label/HOME";
      fsType = "btrfs";
      options = [
        "noatime"
        "nodiratime"
        "discard"
      ];
    };

  fileSystems."/drive2" =
    {
      device = "/dev/disk/by-label/DRIVE2";
      fsType = "ext4";
      options = [
        "noatime"
        "nodiratime"
        "discard"
      ];
    };


  swapDevices =
    [{ device = "/dev/disk/by-label/SWAP"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp15s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp16s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  services.fstrim.enable = lib.mkDefault true;
  nix.settings.auto-optimise-store = true;
}
