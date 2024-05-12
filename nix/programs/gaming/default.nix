{ pkgs
, config
, ...
}: {
  imports = [
    # ./anyrun.nix
    #   ./config.nix
  ];

  environment.systemPackages = with pkgs; [
    gamemode
    steam
    lutris
    wine
    adwsteamgtk
  ];

  programs.steam.enable = true;
  programs.gamemode.enable = true;
  programs.gamemode = {
    enableRenice = true;
    settings = {
      general = {
        governor = "performance";
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = config.programs.gamemode.device;
        amd_performance_level = "high";
      };
      custom = {
        start = "notify-send -a 'Gamemode' 'Optimizations activated'";
        end = "notify-send -a 'Gamemode' 'Optimizations deactivated'";
      };
    };
  };
}
