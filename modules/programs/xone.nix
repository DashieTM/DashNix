{
  lib,
  config,
  options,
  ...
}: {
  options.mods = {
    xone.enable = lib.mkOption {
      default = false;
      type = lib.types.bool;
      example = true;
      description = ''
        Enables the xone driver for xbox controllers.
      '';
    };
  };

  config = lib.optionalAttrs (options ? hardware) {hardware.xone.enable = true;};
}
