{
  lib,
  config,
  options,
  ...
}: {
  options.conf = {
    system = lib.mkOption {
      default = "x86_64-linux";
      # no fisherprice unix support
      type = with lib.types; (enum [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-linux-android"
      ]);
      example = "aarch64-linux";
      description = ''
        System architecture.
      '';
    };

    systemLocalTime = lib.mkOption {
      default = false;
      example = true;
      description = ''
        System time for dualbooting
      '';
    };

    wsl = lib.mkOption {
      default = false;
      example = true;
      description = ''
        Runs Nix in wsl
      '';
    };

    secureBoot = lib.mkOption {
      default = false;
      example = true;
      description = ''
        enables secure boot.
        Note: Secure boot is NOT reproducible
        Here are the necessary steps:
        + create your keys with sbctl -> sudo sbctl create-keys
        + build with systemd once -> set this to false and build once
        + build with secureBoot true
        + verify that your keys are signed (note, only systemd and your generations should now be signed): sudo sbtcl verify
        + enroll your keys (microsoft is necessary for windows dualboot support, leave it there): sudo sbctl enroll-keys --microsoft
        + reboot with secureboot enabled
        Note: Some motherboards have vendor specific keys for secure boot, this may not necessarily work with our self signed keys
        You likely have to disable these vendor specific keys (example HP: sure boot)
      '';
    };

    useSystemdBootloader = lib.mkOption {
      default = true;
      example = false;
      description = ''
        use systemd bootloader.
      '';
    };

    cpu = lib.mkOption {
      # TODO: how to enable arm?
      default = "amd";
      type = with lib.types; (enum [
        "amd"
        "intel"
      ]);
      example = "intel";
      description = ''
        cpu microcode.
      '';
    };

    additionalBootKernalParams = lib.mkOption {
      default = [
        # TODO test if needed
        #"video=${config.conf.defaultMonitor}:${config.conf.defaultMonitorMode}"
      ];
      example = [];
      type = with lib.types; listOf str;
      description = ''
        additional kernelParams passed to bootloader
      '';
    };

    bootParams = lib.mkOption {
      default = [];
      example = ["resume=something"];
      type = with lib.types; listOf str;
      description = ''
        Boot params
      '';
    };

    kernelOverride = lib.mkOption {
      default = null;
      type = with lib.types; nullOr package;
      description = ''
        kernel to be used
        Has no examples as doc complains...
        #example = pkgs.linuxPackages_xanmod_latest;
      '';
    };

    username = lib.mkOption {
      default = "DashNix";
      example = "pingpang";
      type = lib.types.str;
      description = ''
        The username.
      '';
    };

    timezone = lib.mkOption {
      default = "Europe/Zurich";
      example = "Europe/Berlin";
      type = lib.types.str;
      description = ''
        The timezone.
      '';
    };

    locale = lib.mkOption {
      default = "en_US.UTF-8";
      example = "de_DE.UTF-8";
      type = lib.types.str;
      description = ''
        The locale.
      '';
    };

    nixosConfigPath = lib.mkOption {
      default = "/home/${config.conf.username}/gits/nixos/.";
      example = "yourpath/.";
      type = lib.types.str;
      description = ''
        The path for your build command, you can then simply type rebuild to switch to a new configuration.
      '';
    };

    systemStateVersion = lib.mkOption {
      example = "24.11";
      default = "23.05";
      type = lib.types.str;
      description = ''
        System state version
      '';
    };
    homeStateVersion = lib.mkOption {
      default = "24.11";
      example = "23.05";
      type = lib.types.str;
      description = ''
        Home state version
      '';
    };
  };

  config =
    (lib.optionalAttrs (options ? system.stateVersion) {
      boot = {
        kernelPackages = lib.mkIf (config.conf.kernelOverride != null) config.conf.kernel;
        kernelParams = config.conf.additionalBootKernalParams;
      };
      system.stateVersion = config.conf.systemStateVersion;
    })
    // (lib.optionalAttrs (options ? home.stateVersion) {
      home.stateVersion = config.conf.homeStateVersion;
    });
}
