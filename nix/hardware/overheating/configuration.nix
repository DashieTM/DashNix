{ pkgs, ... }:
{
  imports = [
    ../../modules/ironbar_config.nix
    ../../modules/boot_params.nix
  ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "overheating";
  programs.ironbar.monitor = "eDP-1";
  programs.boot.boot_params = [];
}
