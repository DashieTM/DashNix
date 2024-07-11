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

    colorscheme = lib.mkOption {
      default = {
        base00 = "1A1B26";
        # base01 = "16161E";
        # base01 = "15161e";
        base01 = "191a25";
        base02 = "2F3549";
        base03 = "444B6A";
        base04 = "787C99";
        base05 = "A9B1D6";
        base06 = "CBCCD1";
        base07 = "D5D6DB";
        base08 = "C0CAF5";
        base09 = "A9B1D6";
        base0A = "0DB9D7";
        base0B = "9ECE6A";
        base0C = "B4F9F8";
        # base0D = "2AC3DE";
        # base0D = "A9B1D6";
        # base0D = "62A0EA";
        # base0D = "779EF1";
        base0D = "366fea";
        base0E = "BB9AF7";
        base0F = "F7768E";
      };
      example = { base00 = "FFFFFF"; };
      type = with lib.types; attrs;
      description = ''
        Base16 colorscheme.
      '';
    };
  };

  config = {
    conf.boot_params = lib.mkIf config.conf.amdGpu [
      "amdgpu.ppfeaturemask=0xffffffff"
    ];

    conf.kernel = lib.mkIf config.conf.gaming.enable pkgs.linuxPackages_xanmod_latest;
  };
}
