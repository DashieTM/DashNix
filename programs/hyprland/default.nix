{ pkgs
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
    nautilus
    sushi
    nautilus-python
    wl-clipboard
    hyprcursor
    hyprpaper
    hyprpicker
  ];
}
