{
  lib,
  config,
  options,
  pkgs,
  ...
}:
{
  options.mods.keepassxc = {
    enable = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Enables the piper program and its daemon";
    };
    use_cache_config = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Whether to overwrite the cache config of keepassxc. Note, this means that changes can't be applied via the program anymore!";
    };
    cache_config = lib.mkOption {
      default = ''
        [General]
        LastDatabases=/home/${config.conf.username}/pws/Passwords.kdbx
        LastActiveDatabase=/home/${config.conf.username}/pws/Passwords.kdbx
        LastOpenedDatabases=/home/${config.conf.username}/pws/Passwords.kdbx
        LastKeyFiles=@Variant(\0\0\0\x1c\0\0\0\x1\0\0\0>\0/\0h\0o\0m\0\x65\0/\0\x64\0\x61\0s\0h\0i\0\x65\0/\0p\0w\0s\0/\0P\0\x61\0s\0s\0w\0o\0r\0\x64\0s\0.\0k\0\x64\0\x62\0x\0\0\0\n\0\0\0>\0/\0h\0o\0m\0\x65\0/\0\x64\0\x61\0s\0h\0i\0\x65\0/\0p\0w\0s\0/\0l\0o\0g\0i\0n\0_\0k\0\x65\0y\0.\0k\0\x65\0y\0x)
      '';
      example = "";
      type = lib.types.lines;
      description = "Cache config to be used.";
    };
  };
  config = lib.mkIf config.mods.keepassxc.enable (
    lib.optionalAttrs (options ? home.file) {
      home.packages = [ pkgs.keepassxc ];
      xdg.configFile."keepassxc/keepassxc.ini" = {
        text = ''
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
      };

      home.file.".cache/keepassxc/keepassxc.ini" = lib.mkIf config.mods.keepassxc.use_cache_config {
        text = config.mods.keepassxc.cache_config;
      };
    }
  );
}
