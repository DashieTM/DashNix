{
  lib,
  config,
  options,
  ...
}:
{
  options.mods.yazi = {
    enable = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Enables yazi";
    };
  };
  config = lib.mkIf config.mods.yazi.enable (
    lib.optionalAttrs (options ? home.packages) { programs.yazi = import ./yazi.nix; }
  );
}
