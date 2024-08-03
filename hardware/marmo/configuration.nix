{
  imports = [
    ../../modules
  ];
  # variables for system
  conf = {
    monitor = "DP-1";
    gaming = {
      enable = true;
      device = 1;
    };
    hostname = "marmo";
    colorscheme = "catppuccin-mocha";
  };
  mods = {
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
  };
}
