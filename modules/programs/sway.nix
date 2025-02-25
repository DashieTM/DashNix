{
  lib,
  config,
  options,
  ...
}: {
  options.mods.sway = {
    enable = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
      description = "Enables sway";
    };
    config = lib.mkOption {
      default = {};
      example = {};
      type = with lib.types; attrsOf anything;
      description = "sway config";
    };
  };
  config = lib.mkIf config.mods.sway.enable (
    lib.optionalAttrs (options ? wayland.windowManger.sway) {
      wayland.windowManager.sway =
        {
          enable = true;
        }
        // config.mods.sway.config;
    }
  );
}
