{
  lib,
  config,
  options,
  ...
}: {
  options.mods.browser.librewolf = {
    enable = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
      description = "Enables the librwolf browser";
    };
    settings = lib.mkOption {
      default = {};
      example = {};
      type = with lib.types; attrsOf anything;
      description = "librewolf settings";
    };
  };
  config = lib.mkIf config.mods.browser.librewolf.enable (
    lib.optionalAttrs (options ? home.packages) {
      programs.librewolf = {
        enable = true;
        settings = config.mods.browser.librewolf.settings;
      };
    }
  );
}
