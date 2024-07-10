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
    battery = lib.mkOption {
      default = [ ];
      example = [ ];
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
      # type = lib.types.package;
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
  };

  config = {
    conf.boot_params = lib.mkIf config.conf.amdGpu [
      "amdgpu.ppfeaturemask=0xffffffff"
    ];

    conf.kernel = lib.mkIf config.conf.gaming.enable pkgs.linuxPackages_xanmod_latest;
  };
}
