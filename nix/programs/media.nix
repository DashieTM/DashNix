{ pkgs, ...}:
{
  home.packages = with pkgs; [
    # base audio
    pipewire
    wireplumber
    # audio control
    playerctl
    # images
    imv
    # videos
    mpv
    # pdf
    zathura
    evince
    libreoffice-fresh
    pdftk
    # spotify
    #ncspot
    # video editing
    kdenlive
    # image creation
    inkscape
    gimp
    krita
    # recording
    obs-studio
  ];
}
