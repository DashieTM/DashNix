{ pkgs, lib, ... }:
{
  imports = [
    ../../modules/gamemode.nix
    ../../modules/boot_params.nix
    ../../modules/ironbar_config.nix
  ];
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  programs.boot.boot_params = [
    "amdgpu.ppfeaturemask=0xffffffff"
  ];
  networking.hostName = "spaceship";

  programs.gamemode = {
    device = 0;
  };
  users.extraGroups.vboxusers.members = [ "dashie" ];
  virtualisation.virtualbox.host.enable = true;

  # enable hardware acceleration and rocm
  hardware.xone.enable = true;
  hardware.opengl.extraPackages = with pkgs; [
    libvdpau-va-gl
    vaapiVdpau
    rocmPackages.clr.icd
    rocm-opencl-runtime
  ];
  hardware.opengl = {
    enable = true;
    driSupport = lib.mkDefault true;
    driSupport32Bit = lib.mkDefault true;
  };
  boot.initrd.kernelModules = [ "amdgpu" ];
  programs.ironbar.monitor = "DP-1";
}
