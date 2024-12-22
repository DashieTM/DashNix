{
  lib,
  config,
  options,
  ...
}:
{
  options.mods.plymouth = {
    enable = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Enables the plymouth";
    };
  };
  config = lib.mkIf config.mods.plymouth.enable (
    lib.optionalAttrs (options ? boot.plymouth) { boot.plymouth.enable = true; }
  );
}
