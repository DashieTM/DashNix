{
  lib,
  config,
  options,
  ...
}:
{
  options.mods.oxi.oxishut = {
    enable = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Enables and configures oxishut";
    };
  };
  config = lib.mkIf (config.mods.oxi.oxishut.enable && config.mods.oxi.enable) (
    lib.optionalAttrs (options ? xdg.configFile) {
      programs.oxishut.enable = true;
      xdg.configFile."oxishut/style.css" = {
        text = ''
          #mainwindow {
            border-radius: 10px;
          }

          .mainbox {
            border-radius: 5px;
            padding: 20px;
          }

          .button {
            margin: 5px;
            background-color: #2b2c3b;
            -gtk-icon-size: 5rem;
          }

          .button:hover {
            background-color: #3e4152;
          }
        '';
      };
    }
  );
}
