{ lib, config, options, ... }: {

  options.mods = {
    virtualbox.enable = lib.mkOption {
      default = false;
      type = lib.types.bool;
      example = true;
      description = ''
        Enables virtualbox.
      '';
    };
  };

  config = lib.optionalAttrs (options ? virtualisation.virtualbox.host) {
    virtualisation.virtualbox.host.enable =
      lib.mkIf config.mods.virtualbox.enable true;
  };
}
