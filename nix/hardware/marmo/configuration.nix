{ pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [
    "amdgpu.ppfeaturemask=0xffffffff"
  ];
  networking.hostName = "marmo";

}
