{ lib, config, pkgs, options, ... }: {
  options.conf = {

    system = lib.mkOption {
      default = "x86_64-linux";
      # no fisherprice unix support
      type = with lib.types; (enum [ "x86_64-linux" "aarch64-linux" "aarch64-linux-android" ]);
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
        example = [
          { type = "upower"; class = "memory-usage"; }
        ];
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

      kernel = lib.mkOption {
        default = true;
        example = false;
        type = lib.types.bool;
        description = ''
          Install the gaming(xanmod) kernel.
        '';
      };

      gamemode_gpu = lib.mkOption {
        default = true;
        example = false;
        type = lib.types.bool;
        description = ''
          Use GPU optimization.
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
          "DP-1,3440x1440@180,2560x0,1,vrr,0"
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

    colorscheme = lib.mkOption {
      default = {
        # custom tokyo night
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
      example = "catppuccin-mocha";
      type = with lib.types; oneOf [ str attrs path ];
      description = ''
        Base16 colorscheme.
        Can be an attribute set with base00 to base0F,
        a string that leads to a yaml file in base16-schemes path,
        or a path to a custom yaml file.
      '';
    };


  };

  config = {
    conf.kernel = lib.mkIf (config.conf.gaming.enable && config.conf.gaming.kernel) pkgs.linuxPackages_xanmod_latest;
  } // (lib.optionalAttrs (options?system.stateVersion)
    {
      system.stateVersion = "unstable";
    }
  );
}
