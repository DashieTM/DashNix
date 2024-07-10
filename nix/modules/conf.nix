{ lib, config, pkgs, ... }: {
  options.conf = {
    monitor = lib.mkOption {
      default = "";
      example = "eDP-1";
      type = lib.types.str;
      description = ''
        main monitor
      '';
    };

    scale = lib.mkOption {
      default = "1.0";
      example = "1.0";
      type = lib.types.str;
      description = ''
        Scale for the monitor
      '';
    };

    ironbar = {
      modules = lib.mkOption {
        default = [ ];
        example = [
          { type = "upower"; class = "memory-usage"; }
        ];
        type = with lib.types; listOf attrs;
        description = ''
          Adds modules to ironbar.
        '';
      };
    };

    amdGpu = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
      description = ''
        Enables drivers, optimizations and kernel parameters for AMD gpus.
      '';
    };

    boot_params = lib.mkOption {
      default = [ ];
      example = [ "resume=something" ];
      type = with lib.types; listOf str;
      description = ''
        Boot params
      '';
    };

    gaming = {
      enable = lib.mkOption {
        default = false;
        example = true;
        type = lib.types.bool;
        description = ''
          Install gaming related programs such as steam, gamemode, and more
        '';
      };

      device = lib.mkOption {
        default = 0;
        example = 0;
        type = lib.types.int;
        description = ''
          GPU device number
        '';
      };
    };

    streamdeck = {
      enable = lib.mkOption {
        default = false;
        example = true;
        type = lib.types.bool;
        description = ''
          Install streamdeck configuration program.
        '';
      };
    };

    kernel = lib.mkOption {
      default = pkgs.linuxPackages_latest;
      example = pkgs.linuxPackages_xanmod_latest;
      type = with lib.types; nullOr attrs;
      description = ''
        kernel to be used
      '';
    };

    hostname = lib.mkOption {
      default = "nixos";
      example = "spaceship";
      type = lib.types.str;
      description = ''
        The name of the system
      '';
    };

    username = lib.mkOption {
      default = "dashie";
      example = "pingpang";
      type = lib.types.str;
      description = ''
        The username.
      '';
    };

    hyprland = {
      monitor = lib.mkOption {
        default = [ ];
        example = [
          "DP-1,3440x1440@180,2560x0,1,vrr,1"
        ];
        type = with lib.types; listOf str;
        description = ''
          The monitor configuration for hyprland.
        '';
      };
      workspace = lib.mkOption {
        default = [ ];
        example = [
          "2,monitor:DP-1, default:true"
        ];
        type = with lib.types; listOf str;
        description = ''
          The workspace configuration for hyprland.
        '';
      };
      hyprpaper = lib.mkOption {
        default = '''';
        example = ''
          hyprpaper stuff
        '';
        type = lib.types.lines;
        description = ''
          hyprpaper
        '';
      };
      extra_autostart = lib.mkOption {
        default = [ ];
        example = [ "your application" ];
        type = lib.types.listOf lib.types.str;
        description = ''
          Extra exec_once.
        '';
      };
    };
  };

  config = {
    conf.boot_params = lib.mkIf config.conf.amdGpu [
      "amdgpu.ppfeaturemask=0xffffffff"
    ];

    conf.kernel = lib.mkIf config.conf.gaming.enable pkgs.linuxPackages_xanmod_latest;
  };
}
