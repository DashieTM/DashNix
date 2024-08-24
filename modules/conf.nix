{ lib, config, pkgs, options, ... }: {
  options.conf = {

    system = lib.mkOption {
      default = "x86_64-linux";
      # no fisherprice unix support
      type = with lib.types;
        (enum [ "x86_64-linux" "aarch64-linux" "aarch64-linux-android" ]);
      example = "aarch64-linux";
      description = ''
        System architecture.
      '';
    };

    cpu = lib.mkOption {
      # TODO: how to enable arm?
      default = "amd";
      type = with lib.types; (enum [ "amd" "intel" ]);
      example = "intel";
      description = ''
        cpu microcode.
      '';
    };

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
        example = [{
          type = "upower";
          class = "memory-usage";
        }];
        type = with lib.types; listOf attrs;
        description = ''
          Adds modules to ironbar.
        '';
      };
    };

    boot_params = lib.mkOption {
      default = [ ];
      example = [ "resume=something" ];
      type = with lib.types; listOf str;
      description = ''
        Boot params
      '';
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

    nixos-config-path = lib.mkOption {
      default = "/home/${config.conf.username}/gits/nixos/.";
      example = "yourpath/.";
      type = lib.types.str;
      description = ''
        The path for your build command, you can then simply type rebuild to switch to a new configuration.
      '';
    };

    nvim-colorscheme = lib.mkOption {
      default = { tokyonight = { enable = true; }; };
      example = { catppuccin = { enable = true; }; };
      type = lib.types.attrs;
      description = ''
        nixvim colorscheme.
      '';
    };

    nix_path = lib.mkOption {
      default = "/home${config.conf.username}/gits/dotFiles";
      example = "yourpath";
      type = lib.types.str;
      description = ''
        The default path for your configuration.
      '';
    };

    kb_layout = lib.mkOption {
      default = "dashie";
      example = "us";
      type = lib.types.str;
      description = ''
        The layout used in services. 
      '';
    };

    system_state_version = lib.mkOption {
      default = "unstable";
      example = "24.05";
      type = lib.types.str;
      description = ''
        System state version 
      '';
    };

  };

  config = {
    conf.kernel =
      lib.mkIf (config.mods.gaming.enable && config.mods.gaming.kernel)
      pkgs.linuxPackages_xanmod_latest;
  } // (lib.optionalAttrs (options ? system.stateVersion) {
    system.stateVersion = "unstable";
  });
}
