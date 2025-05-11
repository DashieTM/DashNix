{
  lib,
  config,
  options,
  pkgs,
  ...
}: {
  options.mods.keepassxc = {
    enable = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Enables the piper program and its daemon";
    };
    useConfig = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Whether to overwrite the config of keepassxc. Note, this means that changes can't be applied via the program anymore!";
    };
    config = lib.mkOption {
      default = ''
        [General]
        ConfigVersion=2

        [Browser]
        Enabled=true

        [GUI]
        ApplicationTheme=classic
        HidePasswords=true
        MinimizeOnClose=true
        MinimizeToTray=true
        ShowTrayIcon=true
        TrayIconAppearance=monochrome-light

        [PasswordGenerator]
        Length=30

        [Security]
        EnableCopyOnDoubleClick=true
      '';
      example = "";
      type = lib.types.lines;
      description = "Cache config to be used.";
    };
    useCacheConfig = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
      description = "Whether to overwrite the cache config of keepassxc. Note, this means that changes can't be applied via the program anymore!";
    };
    cacheConfig = lib.mkOption {
      default = '''';
      example = ''
        [General]
        LastDatabases=/path/to/database
      '';
      type = lib.types.lines;
      description = "Cache config to be used.";
    };
  };
  config = lib.mkIf config.mods.keepassxc.enable (
    lib.optionalAttrs (options ? home.file) {
      home.packages = [pkgs.keepassxc];
      xdg.configFile."keepassxc/keepassxc.ini" = lib.mkIf config.mods.keepassxc.useConfig {
        text = config.mods.keepassxc.config;
      };

      home.file.".cache/keepassxc/keepassxc.ini" = lib.mkIf config.mods.keepassxc.useCacheConfig {
        text = config.mods.keepassxc.cacheConfig;
      };
    }
  );
}
