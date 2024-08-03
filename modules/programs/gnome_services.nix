{ lib, config, options, pkgs, ... }: {

  options.mods = {
    gnome_services.enable = lib.mkOption {
      default = true;
      type = lib.types.bool;
      example = false;
      description = ''
        Enables gnome services: keyring and settings daemon.
        Note: Do not use these for environments which ship these functionalities by default: GNOME, KDE
      '';
    };
  };

  config = lib.mkIf config.mods.gnome_services.enable (lib.optionalAttrs (options?services.gnome.gnome-keyring) {
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
  });
}
