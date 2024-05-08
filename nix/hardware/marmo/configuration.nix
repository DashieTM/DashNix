{ pkgs, ... }:
{
  imports = [
    ../../modules/gamemode.nix
  ];
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [
    "amdgpu.ppfeaturemask=0xffffffff"
  ];
  networking.hostName = "marmo";
  programs.gamemode = {
    device = 1;
  };
}
