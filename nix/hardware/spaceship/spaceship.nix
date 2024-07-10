{ pkgs, config, lib, modulesPath, ... }:
{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

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

  virtualisation.virtualbox.host.enable = true;

  # enable hardware acceleration and rocm
  hardware.xone.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    libvdpau-va-gl
    vaapiVdpau
    # DUDE FOR FUCK SAKE
    # TODO:
    # rocmPackages.clr.icd
    # rocm-opencl-runtime
  ];
  hardware.graphics = {
    enable = true;
    enable32Bit = lib.mkDefault true;
  };
  networking.firewall = {
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
  };
}
