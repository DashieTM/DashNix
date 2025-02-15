{
  lib,
  options,
  config,
  ...
}: {
  options.mods.sddm = {
    enable = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
      description = "Enables the sddm displayManager";
    };
    useDefaultOptions = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Use default options provided by module. If disabled, will only apply extraOptions.";
    };
    extraOptions = lib.mkOption {
      default = {};
      example = {
        wayland.enable = false;
      };
      type = with lib.types; attrsOf anything;
      description = "Extra options to be applied to the sddm config";
    };
  };

  config = lib.mkIf config.mods.sddm.enable (
    lib.optionalAttrs (options ? services.displayManager.sddm) (
      {
        services.displayManager.sddm.enable = true;
      }
      // lib.mkIf config.mods.sddm.useDefaultOptions {
        services.displayManager.sddm.wayland.enable = true;
      }
      // {
        services.displayManager.sddm = config.mods.sddm.extraOptions;
      }
    )
  );
}
