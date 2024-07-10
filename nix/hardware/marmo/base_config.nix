{
  imports = [
    ../../modules
  ];
  wayland.windowManager.hyprland.settings.monitor = [
    # default
    "DP-1,1920x1080@144,0x0,1"
    # all others
    ",highrr,auto,1"
  ];
  conf.monitor = "DP-1";
}
