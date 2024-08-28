{
  # variables for system
  # TODO important changes
  conf = {
    # change this to your monitor and your pc name
    # should be something like DP-1
    monitor = "YOURMONITOR";
    # your username
    username = "YOURNAME";
    # the name of your system
    hostname = "YOURNAME";
    # TODO only needed when you use intel -> amd is default
    # cpu = "intel";
    locale = "something.UTF-8";
    timezone = "CONTINENT/CITY";
  };
  # modules
  mods = {
    # default disk config has root home boot and swap partition, overwrite if you want something different
    drives = {
      defaultDrives.enable = false;
      extraDrives = [
        {
          name = "boot";
          drive = {
            device = "/dev/disk/by-label/BOOT";
            fsType = "vfat";
            options = [
              "rw"
              "fmask=0022"
              "dmask=0022"
              "noatime"
            ];
          };
        }
        {
          name = "";
          drive = {
            device = "/dev/disk/by-label/ROOT";
            fsType = "ext4";
            options = [
              "noatime"
              "nodiratime"
              "discard"
            ];
          };
        }
      ];
    };
    sops.enable = false;
    nextcloud.enable = false;
    hyprland.monitor = [
      # default
      # TODO change this to your resolution
      "DP-1,1920x1080@144,0x0,1"
      # all others
      ",highrr,auto,1"
    ];
    # or amd, whatever you have
    gpu.nvidia.enable = true;
    kde_connect.enable = true;
    # TODO change this to your main resolution
    # -> this will be your login manager
    greetd = {
      resolution = "3440x1440@180";
    };
  };
}
