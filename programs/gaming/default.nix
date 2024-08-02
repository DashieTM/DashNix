{ pkgs
, lib
, config
, ...
}: lib.mkIf config.conf.gaming.enable {
  environment.systemPackages = with pkgs; [
    gamemode
    steam
    lutris
    wine
    adwsteamgtk
    heroic
  ];

  programs.steam.enable = true;
  programs.gamemode.enable = true;
  programs.gamemode = {
    enableRenice = true;
    settings = {
      general = {
        governor = "performance";
      };
      gpu = lib.mkIf config.conf.gaming.gamemode_gpu {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = config.conf.gaming.device;
        amd_performance_level = "high";
        nv_powermizer_mode = 1;
      };
      custom = {
        start = "notify-send -a 'Gamemode' 'Optimizations activated'";
        end = "notify-send -a 'Gamemode' 'Optimizations deactivated'";
      };
    };
  };
}
