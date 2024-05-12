{ inputs
, pkgs
, ...
}: {
  imports = [
    ./anyrun.nix
    ./config.nix
    ./ironbar.nix
    ./hyprpaper.nix
    ./hyprlock.nix
  ];

  home.packages = with pkgs; [
    xorg.xprop
    grim
    slurp
    satty
    xdg-desktop-portal-gtk
    # xdg-desktop-portal-hyprland
    copyq
    gnome.nautilus
    gnome.sushi
    wl-clipboard
    hyprcursor
    hyprpaper
    hyprpicker
  ];
}
