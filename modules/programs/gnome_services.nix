{
  lib,
  config,
  options,
  pkgs,
  ...
}:
{
  options.mods = {
    gnome_services.enable = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = ''
        Enables gnome services: keyring and settings daemon.
        Note: Do not use these for environments which ship these functionalities by default: GNOME, KDE
      '';
    };
    nautilus.enable = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = ''
        Enables and configures Nautilus
      '';
    };
  };

  config = lib.mkIf config.mods.gnome_services.enable (
    lib.optionalAttrs (options ? services.gnome.gnome-keyring) {
      programs.dconf.enable = true;
      services = {
        # needed for GNOME services outside of GNOME Desktop
        dbus.packages = with pkgs; [
          gcr
          gnome.gnome-settings-daemon
        ];

        gnome.gnome-keyring.enable = true;
        gvfs.enable = true;
      };
    }
    // lib.optionalAttrs (options ? home.packages) {
      home.packages =
        let
          packages = with pkgs; [
            nautilus
            sushi
            nautilus-python
          ];
        in
        lib.mkIf config.mods.nautilus.enable packages;
    }
  );
}
