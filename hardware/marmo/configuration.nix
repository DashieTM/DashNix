{ config, ... }: {
  imports = [
    ../../modules
  ];
  # variables for system
  conf = {
    monitor = "DP-1";
    hostname = "marmo";
  };
  mods = {
    gaming = {
      enable = true;
      gpu_device = 1;
    };
    stylix.colorscheme = "catppuccin-mocha";
    hyprland.monitor = [
      # default
      "DP-1,1920x1080@144,0x0,1"
      # all others
      ",highrr,auto,1"
    ];
    amdgpu.enable = true;
    kde_connect.enable = true;
    xone.enable = true;
    greetd = {
      resolution = "3440x1440@180";
    };
    nextcloud = {
      synclist = [
        {
          name = "pw_sync";
          remote = "/PWs";
          local = "/home/${config.conf.username}/PWs";
        }
      ];
    };
  };
}
