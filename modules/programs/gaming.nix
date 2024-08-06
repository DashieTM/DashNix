{ lib, config, options, pkgs, ... }: {
  options.mods.gaming = {
    enable = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
      description = "Enabled gaming related features.";
    };
    tools = lib.mkOption {
      default = with pkgs; [
        gamemode
        steam
        lutris
        wine
        adwsteamgtk
        heroic
      ];
      example = [ ];
      type = with lib.types; listOf packages;
      description = "Install gaming related packages";
    };
    steam = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Whether to use steam";
    };
    gamemode = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Whether to use gamemode";
    };
    gpu_optimization = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Whether to use GPU performance setting. NOTE: this is at your own risk!";
    };
    gpu_device = lib.mkOption {
      default = "0";
      example = "1";
      type = lib.types.str;
      description = "Your gpu device.(Physical id of lshw)";
    };
  };
  config = lib.mkIf config.mods.gaming.enable
    (lib.optionalAttrs (options?environment.systemPackages) {
      environment.systemPackages = config.mods.gaming.tools;

      programs.steam.enable = config.mods.gaming.steam;
      programs.gamemode.enable = true;
      programs.gamemode = {
        enableRenice = true;
        settings = {
          general = {
            governor = "performance";
          };
          gpu = lib.mkIf config.mods.gaming.gpu_optimization {
            apply_gpu_optimisations = "accept-responsibility";
            gpu_device = config.mods.gaming.gpu_device;
            amd_performance_level = "high";
            nv_powermizer_mode = 1;
          };
          custom = {
            start = "notify-send -a 'Gamemode' 'Optimizations activated'";
            end = "notify-send -a 'Gamemode' 'Optimizations deactivated'";
          };
        };
      };
    });
}
