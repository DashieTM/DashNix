{
  lib,
  pkgs,
  config,
  options,
  ...
}: {
  options.mods = {
    streamcontroller = {
      enable = lib.mkOption {
        default = true;
        example = false;
        type = lib.types.bool;
        description = ''
          Enables starship prompt
        '';
      };
      configFilePath = lib.mkOption {
        default = null;
        type = with lib.types; nullOr path;
        description = ''
          Path to the config json for the streamcontroller.
          -> ./something.json
        '';
      };
    };
  };

  config = lib.mkIf config.mods.streamcontroller.enable (
    lib.optionalAttrs (options ? environment.systemPackages) {
      programs.streamcontroller.enable = true;
    }
    // (lib.optionalAttrs (options ? home.file) {
      home.file."var/app/com.core447.StreamController/data/pages/defaultpage.json".path = lib.mkIf (!isNull config.mods.streamcontroller.path) config.mods.streamcontroller.path;
    })
  );
}
