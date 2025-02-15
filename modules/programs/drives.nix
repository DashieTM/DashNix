{
  lib,
  config,
  options,
  ...
}: let
  driveModule = lib.types.submodule {
    options = {
      name = lib.mkOption {
        type = lib.types.str;
        description = ''
          The path of the drive.
          Note that a / is already added at the beginning.
        '';
        default = "";
        example = "drive2";
      };
      drive = lib.mkOption {
        type = lib.types.attrsOf lib.types.anything;
        description = "The attrs of the drive";
        default = {};
        example = {
          device = "/dev/disk/by-label/DRIVE2";
          fsType = "ext4";
          options = [
            "noatime"
            "nodiratime"
            "discard"
          ];
        };
      };
    };
  };
in {
  options.mods = {
    drives = {
      useSwap = {
        enable = lib.mkOption {
          default = true;
          example = false;
          type = lib.types.bool;
          description = ''
            Use default drive config
          '';
        };
      };
      defaultDrives = {
        enable = lib.mkOption {
          default = true;
          example = false;
          type = lib.types.bool;
          description = ''
            Use default drive config
          '';
        };
      };
      extraDrives = lib.mkOption {
        default = [
        ];
        example = [
          {
            name = "drive2";
            drive = {
              device = "/dev/disk/by-label/DRIVE2";
              fsType = "ext4";
              options = [
                "noatime"
                "nodiratime"
                "discard"
              ];
            };
          }
        ];
        #  TODO:  how to make this work
        # type = with lib.types; listOf (attrsOf driveModule);
        type = with lib.types; listOf (attrsOf anything);
        description = ''
          Extra drives to add.
        '';
      };
    };
  };

  config = (
    lib.optionalAttrs (options ? fileSystems) {
      fileSystems =
        builtins.listToAttrs (
          map (
            {
              name,
              drive,
            }: {
              name = "/" + name;
              value = drive;
            }
          )
          config.mods.drives.extraDrives
        )
        // (lib.optionalAttrs config.mods.drives.defaultDrives.enable) {
          "/" = {
            device = "/dev/disk/by-label/ROOT";
            fsType = "btrfs";
            options = [
              "noatime"
              "nodiratime"
              "discard"
            ];
          };

          "/boot" = {
            device = "/dev/disk/by-label/BOOT";
            fsType = "vfat";
            options = [
              "rw"
              "fmask=0022"
              "dmask=0022"
              "noatime"
            ];
          };

          "/home" = {
            device = "/dev/disk/by-label/HOME";
            fsType = "btrfs";
            options = [
              "noatime"
              "nodiratime"
              "discard"
            ];
          };
        };
      # TODO make this convert to choice of drives -> thanks to funny types this doesn't work...
      swapDevices = lib.mkIf config.mods.drives.useSwap.enable [
        {device = "/dev/disk/by-label/SWAP";}
      ];
    }
  );
}
