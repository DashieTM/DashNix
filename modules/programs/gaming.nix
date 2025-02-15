{
  lib,
  config,
  options,
  pkgs,
  ...
}: {
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
        # TODO broken
        #heroic
        mangohud
      ];
      example = [];
      type = with lib.types; listOf package;
      description = "Install gaming related packages";
    };
    kernel = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Whether to use the xanmod kernel";
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
    gpuOptimization = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Whether to use GPU performance setting. NOTE: this is at your own risk!";
    };
    gpuDevice = lib.mkOption {
      default = 0;
      example = 1;
      type = lib.types.int;
      description = "Your gpu device.(Physical id of lshw)";
    };
  };
  config = lib.mkIf config.mods.gaming.enable (
    lib.optionalAttrs (options ? environment.systemPackages) {
      environment.systemPackages = config.mods.gaming.tools;
      boot.kernelPackages = lib.mkForce pkgs.linuxPackages_xanmod_latest;

      programs = {
        steam.enable = config.mods.gaming.steam;
        gamemode.enable = true;
        gamemode = {
          enableRenice = true;
          settings = {
            general = {
              governor = "performance";
            };
            gpu = lib.mkIf config.mods.gaming.gpuOptimization {
              apply_gpu_optimisations = "accept-responsibility";
              gpu_device = config.mods.gaming.gpuDevice;
              amd_performance_level = "high";
              nv_powermizer_mode = 1;
            };
            custom = {
              start = "notify-send -a 'Gamemode' 'Optimizations activated'";
              end = "notify-send -a 'Gamemode' 'Optimizations deactivated'";
            };
          };
        };
      };
    }
  );
}
