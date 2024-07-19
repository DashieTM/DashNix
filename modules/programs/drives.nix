{ lib, config, options, ... }:
let

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
        default = { };
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
in
{
  options.mods = {
    extraDrives =
      lib.mkOption {
        default = [ ];
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

  config = (lib.optionalAttrs (options?fileSystems) {
    fileSystems = builtins.listToAttrs
      (map
        ({ name, drive }: {
          name = "/" + name;
          value = drive;
        })
        config.mods.extraDrives);
  });
}
