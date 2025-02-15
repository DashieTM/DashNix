{
  lib,
  config,
  options,
  pkgs,
  ...
}: {
  options.mods.browser.brave = {
    enable = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
      description = "Enables brave";
    };
    # TODO configure brave
  };
  config = lib.mkIf config.mods.browser.brave.enable (
    lib.optionalAttrs (options ? home.packages) {
      home.packages = with pkgs; [brave];
    }
  );
}
