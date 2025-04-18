{config, ...}: {
  # variables for system
  # TODO important changes
  conf = {
    # change this to your monitor and your pc name
    # should be something like DP-1
    defaultMonitor = "YOURMONITOR";
    # width x height  @ refreshrate
    defaultMonitorMode = "1920x1080@60";
    # scale for your main monitor
    defaultMonitorScale = "1";
    # your username
    username = "YOURNAME";
    # TODO only needed when you use intel -> amd is default
    # cpu = "intel";
    locale = "something.UTF-8";
    timezone = "CONTINENT/CITY";
  };
  # modules
  mods = {
    # default disk config has root home boot and swap partition, overwrite if you want something different
    drives = {
      # WARNING: Only do this when installing for the first time, as I am not sure if disko would format your disk
      variant = "disko";
      # default assumes ROOT, BOOT, HOME and SWAP labaled drives exist
      # for an example without HOME see below
      #defaultDrives.enable = false;
      #extraDrives = [
      #  {
      #    name = "boot";
      #    drive = {
      #      device = "/dev/disk/by-label/BOOT";
      #      fsType = "vfat";
      #      options = [
      #        "rw"
      #        "fmask=0022"
      #        "dmask=0022"
      #        "noatime"
      #      ];
      #    };
      #  }
      #  {
      #    name = "";
      #    drive = {
      #      device = "/dev/disk/by-label/ROOT";
      #      fsType = "ext4";
      #      options = [
      #        "noatime"
      #        "nodiratime"
      #        "discard"
      #      ];
      #    };
      #  }
      #];
    };
    sops.enable = false;
    nextcloud.enable = false;
    # default hyprland monitor config -> uncomment when necessary
    # TODO: Add more monitors when needed
    #   hyprland.monitor = [
    #     # default
    #     "${config.conf.defaultMonitor},${config.conf.defaultMonitorMode},0x0,${config.conf.defaultMonitorScale}"
    #     # second example monitor
    #     "DP-2,3440x1440@180,auto,1"
    #     # all others
    #     ",highrr,auto,1"
    #   ];
    # or amd, whatever you have
    gpu.nvidia.enable = true;
    kdeConnect.enable = true;
    # login manager:
    # default is greetd
    # greetd = { };
    # sddm = { };
    # gdm = { };
  };
}
