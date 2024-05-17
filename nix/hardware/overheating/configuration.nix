{ pkgs, ... }:
{
  imports = [
    ../../modules/ironbar_config.nix
    ../../modules/boot_params.nix
  ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "overheating";
  programs.ironbar.monitor = "eDP-1";
  programs.ironbar.scale = "2.0";
  programs.boot.boot_params = [ ];
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
