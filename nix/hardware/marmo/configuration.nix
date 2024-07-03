{ pkgs, ... }:
{
  imports = [
    ../../modules/gamemode.nix
    ../../modules/boot_params.nix
    ../../modules/ironbar_config.nix
  ];
  boot.kernelPackages = pkgs.linuxPackages_zen;
  programs.boot.boot_params = [
    "amdgpu.ppfeaturemask=0xffffffff"
  ];
  networking.hostName = "marmo";
  programs.ironbar.monitor = "DP-1";
  programs.gamemode = {
    device = 1;
  };
}
