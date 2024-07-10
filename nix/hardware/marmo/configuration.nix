{
  imports = [
    ../../modules/conf.nix
  ];
  # variables for system
  conf = {
    monitor = "DP-1";
    gaming = {
      enable = true;
      device = 1;
    };
    hostname = "marmo";
    hyprland.monitor = [
      # default
      "DP-1,1920x1080@144,0x0,1"
      # all others
      ",highrr,auto,1"
    ];
  };
}
