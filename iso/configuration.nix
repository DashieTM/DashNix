{
  pkgs,
  lib,
  modulesPath,
  self,
  ...
}:
{

  imports = [ "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix" ];
  nixpkgs.hostPlatform = {
    system = "x86_64-linux";
  };

  environment.systemPackages = with pkgs; [
    neovim
    disko
    git
    vesktop
    vscodium
    firefox
    kitty
  ];
  networking = {
    wireless.enable = false;
    networkmanager.enable = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = "nixos";
      };
    };
  };

  isoImage = {
    isoName = lib.mkForce "DashNix.iso";
    makeEfiBootable = true;
    makeUsbBootable = true;
    contents = [
      {
        source = "${self}/example";
        target = "example-config";
      }
    ];
  };
}
