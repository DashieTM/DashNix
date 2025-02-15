{
  lib,
  options,
  config,
  ...
}: {
  options.mods.kde = {
    enable = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
      description = "Enables the KDE desktop environment";
    };
  };

  config = lib.mkIf config.mods.kde.enable (
    lib.optionalAttrs (options ? services.desktopManager.plasma6) {
      # apparently kde integration is bad -> kdeconfig is too much even for nix, can't blame them :)
      services.desktopManager.plasma6.enable = true;
    }
  );
}
