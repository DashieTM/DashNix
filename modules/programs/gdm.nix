{
  lib,
  options,
  config,
  ...
}:
{
  options.mods.gdm = {
    enable = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
      description = "Enables the gdm displayManager";
    };
    extraOptions = lib.mkOption {
      default = { };
      example = { };
      type = with lib.types; attrsOf anything;
      description = "Extra options to be applied to the gnome config";
    };
  };

  config = lib.mkIf config.mods.gdm.enable (
    lib.optionalAttrs (options ? services.xserver.displayManager.gdm) (
      {
        services.xserver.enable = true;
        services.xserver.displayManager.gdm.enable = true;
      }
      // {
        services.xserver.displayManager.gdm = config.mods.gdm.extraOptions;
      }
    )
  );
}
