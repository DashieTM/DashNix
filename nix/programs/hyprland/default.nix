{ pkgs
, ...
}: {
  imports = [
    ./anyrun.nix
    ./config.nix
    ./ironbar.nix
    ./hyprpaper.nix
    ./hyprgreet.nix
  ];

  home.packages = with pkgs; [
    xorg.xprop
    grim
    slurp
    swappy
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    hyprpaper
    copyq
    gnome.nautilus
    gnome.sushi
    wl-clipboard
    kooha
    hyprcursor
    hyprpaper
  ];
}
