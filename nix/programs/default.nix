{pkgs, ... }:
{
  imports = [
    ./hyprland/default.nix
    ./common.nix
    ./kitty.nix
    ./coding.nix
    ./xdg.nix
    ./media.nix
  ];

    home.username = "dashie";
    home.homeDirectory = "/home/dashie";
    home.stateVersion = "23.05";
  }
