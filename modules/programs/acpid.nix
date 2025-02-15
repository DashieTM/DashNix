{
  lib,
  config,
  options,
  ...
}: {
  options.mods = {
    acpid.enable = lib.mkOption {
      default = false;
      type = lib.types.bool;
      example = true;
      description = ''
        Enables acpid.
      '';
    };
  };

  config = lib.mkIf config.mods.acpid.enable (
    lib.optionalAttrs (options ? virtualisation.virtualbox.host) {services.acpid.enable = true;}
  );
}
