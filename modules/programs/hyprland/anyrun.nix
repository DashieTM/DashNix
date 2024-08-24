{ lib, config, pkgs, options, inputs, ... }: {
  options.mods = {
    hyprland.anyrun = {
      enable = lib.mkOption {
        default = true;
        example = false;
        type = lib.types.bool;
        description = "Enables anyrun";
      };
    };
  };

  config = lib.mkIf config.mods.hyprland.anyrun.enable
    (lib.optionalAttrs (options ? programs.anyrun) {
      programs.anyrun = {
        enable = true;
        config = {
          plugins = [
            inputs.anyrun.packages.${pkgs.system}.applications
            inputs.anyrun.packages.${pkgs.system}.rink
            inputs.anyrun.packages.${pkgs.system}.translate
            inputs.anyrun.packages.${pkgs.system}.websearch
          ];
          #position = "center";
          hideIcons = false;
          width = { fraction = 0.3; };
          y = { fraction = 0.5; };
          layer = "overlay";
          hidePluginInfo = true;
          closeOnClick = true;
        };

        extraCss = ''
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
        '';
      };
    });
}
