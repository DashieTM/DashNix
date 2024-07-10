{ pkgs, lib, ... }:
{
  imports = [
    ../../modules/conf.nix
  ];

  # config variables
  conf = {
    monitor = "DP-1";
    gaming = {
      enable = true;
    };
    streamdeck.enable = true;
    hostname = "spaceship";
  };

  virtualisation.virtualbox.host.enable = true;

  # enable hardware acceleration and rocm
  hardware.xone.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    libvdpau-va-gl
    vaapiVdpau
    rocmPackages.clr.icd
    rocm-opencl-runtime
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
