{ pkgs, ... }:
{
  imports = [
    ./common.nix
    ./kitty.nix
    ./coding.nix
    ./xdg.nix
    ./media.nix
    ./utils.nix
    #./gtk.nix
    #./cargo.nix
  ];

  home.username = "dashie";
  home.homeDirectory = "/home/dashie";
  home.stateVersion = "24.05";
}
