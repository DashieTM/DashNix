{  
 lib
, pkgs
, ...
}: {
  imports = [ 
    #./anyrun.nix
  ];

  home.packages = with pkgs; [
  hyprland
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
  ];

}
