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
    useDefaultConfig = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Use default yazi config (if disabled only additionalConfig is used)";
    };
    additionalConfig = lib.mkOption {
      default = { };
      example = { };
      type = with lib.types; attrsOf anything;
      description = "Additional config for yazi";
    };
    useDefaultKeymap = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Use default yazi keymap (if disabled only additionalKeymap is used)";
    };
    additionalKeymap = lib.mkOption {
      default = { };
      example = { };
      type = with lib.types; attrsOf anything;
      description = "Additional keymap for yazi";
    };
  };
  config = lib.mkIf config.mods.yazi.enable (
    lib.optionalAttrs (options ? home.packages) { programs.yazi = import ./yazi.nix; }
    // {
      programs.yazi.settings = {
        settings = config.mods.yazi.additionalKeymap;
        keymap = config.mods.yazi.additionalConfig;
      };
    }
  );
}