{ lib, config, options, ... }: {
  options.mods.oxi.oxipaste = {
    enable = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Enables and configures oxipaste";
    };
  };
  config = lib.mkIf (config.mods.oxi.oxipaste.enable && config.mods.oxi.enable)
    (lib.optionalAttrs (options ? xdg.configFile) {
      programs.oxipaste.enable = true;
      xdg.configFile."oxipaste/style.css" = {
        text = ''
          .main-window {
            padding: 10px;
            border-radius: 10px;
            border: 2px solid #2AC3DE;
          }

          .item-window {
            padding: 10px;
            border-radius: 10px;
            border: 2px solid #C0CAF5;
          }

          .item-button {
            background-color: #1A1B26;
            border-radius: 5px;
            border: 1px solid #6D728D;
          }

          .delete-button {
            margin: 5px 25px 5px 5px;
          }

          .item-box {
          }
        '';
      };
    });
}
