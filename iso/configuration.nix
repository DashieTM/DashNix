{
  pkgs,
  lib,
  modulesPath,
  self,
  inputs,
  ...
}: let
  system = "x86_64-linux";
in {
  imports = ["${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"];
  nixpkgs.hostPlatform = {
    system = system;
  };

  environment.systemPackages = with pkgs; [
    neovim
    disko
    git
    vesktop
    vscodium
    firefox
    kitty
    gnome-disk-utility
    inputs.disko.packages.${system}.disko-install
  ];
  networking = {
    wireless.enable = false;
    networkmanager.enable = true;
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # gnome is a good default that works with every gpu and doesn't require knowledge about custom keybinds.
  services = {
    xserver = {
      enable = true;
      displayManager = {
        gdm.enable = true;
      };
      desktopManager = {
        gnome.enable = true;
      };
    };
    displayManager.autoLogin = {
      enable = true;
      user = "nixos";
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
