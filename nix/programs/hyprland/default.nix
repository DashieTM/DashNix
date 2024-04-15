{ lib
, pkgs
, ...
}: {
  imports = [
    ./anyrun.nix
    ./config.nix
  ];

  home.packages = with pkgs; [
    xorg.xprop
    grim
    slurp
    swappy
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    hyprpaper
    ironbar
    copyq
    gnome.nautilus
    gnome.sushi
    wl-clipboard
    kooha
    hyprcursor
    hyprpaper
  ];
}
