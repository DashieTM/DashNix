{
  lib,
  config,
  options,
  pkgs,
  ...
}:
{
  options.mods.piper = {
    enable = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
      description = "Enables the piper program and its daemon";
    };
  };
  config = lib.mkIf config.mods.piper.enable (
    lib.optionalAttrs (options ? services.ratbagd) { services.ratbagd.enable = true; }
    // lib.optionalAttrs (options ? home.packages) { home.packages = with pkgs; [ piper ]; }
  );
}
