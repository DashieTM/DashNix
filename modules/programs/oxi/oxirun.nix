{
  lib,
  config,
  options,
  ...
}: {
  options.mods.oxi.oxirun = {
    enable = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Enables OxiRun";
    };
  };
  config = lib.mkIf (config.mods.oxi.oxirun.enable && config.mods.oxi.enable) (
    lib.optionalAttrs (options ? xdg.configFile) {
      programs.oxirun.enable = true;
    }
  );
}
