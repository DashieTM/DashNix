{ pkgs
, config
, ...
}:
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
    # spotify
    ncspot
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
