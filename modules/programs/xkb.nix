{
  lib,
  options,
  config,
  ...
}: {
  options.mods.xkb = {
    layout = lib.mkOption {
      default = "dashie";
      example = "us";
      type = lib.types.str;
      description = "Your layout";
    };
    variant = lib.mkOption {
      default = "";
      example = "";
      type = lib.types.str;
      description = "Your variant";
    };
  };
  config = (
    lib.optionalAttrs (options ? services.xserver) {
      # Configure keymap in X11
      services.xserver = {
        xkb.layout = "${config.mods.xkb.layout}";
        xkb.variant = "${config.mods.xkb.variant}";
      };
    }
  );
}
