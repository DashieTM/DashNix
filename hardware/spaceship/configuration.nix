{ config, ... }:
let
  username = config.conf.username;
in
{
  imports = [
    ../../modules
  ];

  # config variables
  conf = {
    monitor = "DP-1";
    gaming = {
      enable = true;
    };
    streamdeck.enable = true;
    hostname = "spaceship";
    hyprland = {
      monitor = [
        # default
        "DP-2,2560x1440@165,0x0,1"
        "DP-1,3440x1440@180,2560x0,1,vrr,1"
        "HDMI-A-1,1920x1200@60,6000x0,1"
        "HDMI-A-1,transform,1"

        # all others
        ",highrr,auto,1"
      ];

      workspace = [
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
      hyprpaper = ''
        #load
        preload = /home/${username}/Pictures/backgrounds/shinobu_2k.jpg
        preload = /home/${username}/Pictures/backgrounds/shino_wide.png
        preload = /home/${username}/Pictures/backgrounds/shinobu_1200.jpg

        #set
        wallpaper = DP-2,/home/${username}/Pictures/backgrounds/shinobu_2k.jpg
        wallpaper = DP-1,/home/${username}/Pictures/backgrounds/shino_wide.png
        wallpaper = HDMI-A-1,/home/${username}/Pictures/backgrounds/shinobu_1200.jpg
        splash = true
      '';
      extra_autostart = [ "streamdeck -n" ];
    };
    colorscheme = "catppuccin-mocha";
  };
  mods = {
    extraDrives = [
      {
        name = "drive2";
        drive =
          {
            device = "/dev/disk/by-label/DRIVE2";
            fsType = "ext4";
            options = [
              "noatime"
              "nodiratime"
              "discard"
            ];
          };
      }
    ];
    virtualbox.enable = true;
    kde_connect.enable = true;
    xone.enable = true;
    amdgpu.enable = true;
    vapi = {
      enable = true;
      rocm.enable = true;
    };
  };
}
