{ pkgs, lib, ... }:
{
# TODO: needed?
  boot.kernelModules = [ "kvm-amd" ];

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
