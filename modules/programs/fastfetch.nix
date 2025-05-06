{
  pkgs,
  lib,
  options,
  config,
  ...
}: {
  options.mods = {
    dashfetch = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "A custom configuration for fastfetch";
    };
  };

  config = lib.optionalAttrs (options ? home.packages) {
    xdg.configFile."fastfetch/config.jsonc" = lib.mkIf (config.mods.dashfetch) {
      source = (pkgs.formats.json {}).generate "config.jsonc" {
        "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
        logo = {
          type = "kitty";
          source = ../../assets/logo2.png;
          width = 35;
          padding = {
            top = 1;
          };
        };
        modules = [
          "title"
          "separator"
          {
            type = "os";
            key = "OS";
            format = "DashNix ({name} {version})";
          }
          "host"
          "kernel"
          "uptime"
          "packages"
          "shell"
          "display"
          "de"
          "wm"
          "wmtheme"
          "theme"
          "icons"
          "font"
          "cursor"
          "terminal"
          "terminalfont"
          "cpu"
          "gpu"
          "memory"
          "swap"
          "disk"
          "localip"
          "battery"
          "poweradapter"
          "locale"
          "break"
          "colors"
        ];
      };
    };
  };
}
