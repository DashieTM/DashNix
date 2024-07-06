{ pkgs, ... }:
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
    onlyoffice-bin
    pdftk
    pdfpc
    polylux2pdfpc
    # spotify
    #ncspot
    # video editing
    kdenlive
    # image creation
    inkscape
    gimp
    krita
    yt-dlp
  ];
  programs.obs-studio.enable = true;
  programs.obs-studio.plugins = with pkgs; [
    obs-studio-plugins.obs-vaapi
  ];
}
