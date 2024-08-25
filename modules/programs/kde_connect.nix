{
  lib,
  config,
  options,
  pkgs,
  ...
}:
{

  options.mods = {
    kde_connect.enable = lib.mkOption {
      default = false;
      type = lib.types.bool;
      example = true;
      description = ''
        Enables kde_connect.
      '';
    };
  };

  config = lib.mkIf config.mods.kde_connect.enable (
    lib.optionalAttrs (options ? networking.firewall) {
      networking.firewall = {
        allowedTCPPortRanges = [
          {
            from = 1714;
            to = 1764;
          }
          # KDE Connect
        ];
        allowedUDPPortRanges = [
          {
            from = 1714;
            to = 1764;
          }
          # KDE Connect
        ];
      };
    }
    // lib.optionalAttrs (options ? home.packages) { home.packages = with pkgs; [ kdeconnect ]; }
  );
}
