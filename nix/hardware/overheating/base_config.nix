{
  imports = [
    ../../modules
  ];
  wayland.windowManager.hyprland.settings.monitor = [
    # default
    "eDP-1,2944x1840@90,0x0,2"

    # all others
    ",highres,auto,1"
  ];
  programs.ironbar.monitor = "eDP-1";
  programs.ironbar.battery = [
    { type = "upower"; class = "memory-usage"; }
  ];
  programs.hyprland.extra_autostart = [ "hyprdock --server" ];
}
