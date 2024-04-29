{ pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [
    "amdgpu.ppfeaturemask=0xffffffff"
  ];
  networking.hostName = "spaceship";

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_zen.virtualbox
  ];
}
