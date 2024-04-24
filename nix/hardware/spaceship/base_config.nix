{
  imports = [
    ../../modules
  ];
  wayland.windowManager.hyprland.settings.monitor = [
    # default
    "DP-2,2560x1440@165,0x0,1"
    "DP-1,3440x1440@180,2560x0,1"
    "HDMI-A-1,1920x1200@60,6000x0,1"
    "HDMI-A-1,transform,1"

    # all others
    ",highrr,auto,1"
  ];
  wayland.windowManager.hyprland.settings.workspace = [
    # workspaces
    # monitor middle
    "2,monitor:DP-1, default:true"
    "4,monitor:DP-1"
    "6,monitor:DP-1"
    "8,monitor:DP-1"
    "9,monitor:DP-1"
    "10,monitor:DP-1"

    # monitor left
    "1,monitor:DP-2, default:true"
    "5,monitor:DP-2"
    "7,monitor:DP-2"

    # monitor right
    "3,monitor:HDMI-A-1, default:true"
  ];
  programs.ironbar.monitor = "DP-1";
  programs.hyprland.hyprpaper = ''
    #load
    preload = /home/dashie/Pictures/backgrounds/shinobu_2k.jpg
    preload = /home/dashie/Pictures/backgrounds/shino_wide.png
    preload = /home/dashie/Pictures/backgrounds/shinobu_1200.jpg

    #set
    wallpaper = DP-2,/home/dashie/Pictures/backgrounds/shinobu_2k.jpg
    wallpaper = DP-1,/home/dashie/Pictures/backgrounds/shino_wide.png
    wallpaper = HDMI-A-1,/home/dashie/Pictures/backgrounds/shinobu_1200.jpg
    splash = true
  '';
  programs.hyprland.extra_autostart = [ "streamdeck -n" ];
}
