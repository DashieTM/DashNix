{
  lib,
  config,
  pkgs,
  options,
  inputs,
  ...
}:
{
  options.mods = {
    hyprland = {
      anyrun = {
        enable = lib.mkOption {
          default = true;
          example = false;
          type = lib.types.bool;
          description = "Enables anyrun";
        };
        use_default_config = lib.mkOption {
          default = true;
          example = false;
          type = lib.types.bool;
          description = ''
            Use preconfigured anyrun config.
          '';
        };
        custom_config = lib.mkOption {
          default = { };
          example = { };
          type = with lib.types; attrsOf anything;
          description = ''
            Custom anyrun configuration.
            Will be merged with default configuration if enabled.
          '';
        };
        use_default_css = lib.mkOption {
          default = true;
          example = false;
          type = lib.types.bool;
          description = ''
            Use preconfigured anyrun css.
          '';
        };
        custom_css = lib.mkOption {
          default = { };
          example = { };
          type = with lib.types; attrsOf anything;
          description = ''
            Custom anyrun css.
            Will be merged with default css if enabled.
          '';
        };
      };
    };
  };

  config = lib.mkIf config.mods.hyprland.anyrun.enable (
    lib.optionalAttrs (options ? programs.anyrun) {
      programs.anyrun = {
        enable = true;
        config =
          if config.mods.hyprland.anyrun.use_default_config then
            {
              plugins = [
                inputs.anyrun.packages.${pkgs.system}.applications
                inputs.anyrun.packages.${pkgs.system}.rink
                inputs.anyrun.packages.${pkgs.system}.translate
                inputs.anyrun.packages.${pkgs.system}.websearch
              ];
              #position = "center";
              hideIcons = false;
              width = {
                fraction = 0.3;
              };
              y = {
                fraction = 0.5;
              };
              layer = "overlay";
              hidePluginInfo = true;
              closeOnClick = true;
            }
            // config.mods.hyprland.anyrun.custom_config
          else
            config.mods.hyprland.anyrun.custom_config;

        extraCss =
          if config.mods.hyprland.anyrun.use_default_css then
            ''
              #window {
                border-radius: 10px;
                background-color: none; 
              }

              box#main {
                border-radius: 10px;
              }

              list#main {
                border-radius: 10px;
                margin: 0px 10px 10px 10px;
              }

              list#plugin {
                border-radius: 10px;
              }

              list#match {
                border-radius: 10px;
              }

              entry#entry {
                border: none;
                border-radius: 10px;
                margin: 10px 10px 0px 10px;
              }

              label#match-desc {
                font-size: 12px;
                border-radius: 10px;
              }

              label#match-title {
                font-size: 12px;
                border-radius: 10px;
              }

              label#plugin {
                font-size: 16px;
                border-radius: 10px;
              }

              * {
                border-radius: 10px;
              }
            ''
            ++ config.mods.hyprland.anyrun.custom_css
          else
            config.mods.hyprland.anyrun.custom_css;
      };
    }
  );
}
