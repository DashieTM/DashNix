{ config, lib, modulesPath, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/678ecbd1-a5ce-4530-a959-ffb48f76aa43";
      fsType = "btrfs";
    };

  fileSystems."/var/lib/nextcloud" =
    {
      device = "/dev/disk/by-label/nextcloud";
      fsType = "ext4";
    };

  fileSystems."/mnt/dump3" =
    {
      device = "/dev/disk/by-label/backup";
      fsType = "ext4";
    };

  fileSystems."/mnt/dump1" =
    {
      device = "/dev/disk/by-uuid/CC60532860531912";
      fsType = "ntfs-3g";
      options = [ "rw" "uid=1000" ];
    };

  fileSystems."/mnt/dump2" =
    {
      device = "/dev/disk/by-uuid/F46896AE68966EDC";
      fsType = "ntfs-3g";
      options = [ "rw" "uid=1000" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/B7BE-AB1C";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/832dce11-b4c4-476c-ab28-bd98275a542c"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
