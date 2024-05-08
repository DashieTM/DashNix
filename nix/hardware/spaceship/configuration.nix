{ pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [
    "amdgpu.ppfeaturemask=0xffffffff"
  ];
  networking.hostName = "spaceship";

  programs.gamemode = {
    device = 0;
  };
  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_zen.virtualbox
  ];

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "dashie" ];
  virtualisation.virtualbox.guest.enable = true;
}
