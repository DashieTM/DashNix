{ pkgs, ... }:
{
  imports = [
    ../../modules/gamemode.nix
    ../../modules/boot_params.nix
  ];
  boot.kernelPackages = pkgs.linuxPackages_zen;
  programs.boot.boot_params = [
    "amdgpu.ppfeaturemask=0xffffffff"
  ];
  networking.hostName = "marmo";
  programs.gamemode = {
    device = 1;
  };
}
