{ lib, config, options, ... }: {
  options.mods.oxi.oxidash = {
    enable = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Enables and configures oxidash";
    };
  };
  config = lib.mkIf (config.mods.oxi.oxidash.enable && config.mods.oxi.enable)
    (lib.optionalAttrs (options ? xdg.configFile) {
      programs.oxidash.enable = true;
      xdg.configFile."oxidash/style.css" = {
        text = ''
          #MainWindow {
            border-radius: 10px;
          }

          #MainBox {
            border-radius: 10px;
          }

          #MainButtonBox {
            padding: 10px;
            margin: 5px 0px 5px 0px;
            border-radius: 5px;
            border: solid 2px #327cd5;
          }

          #DoNotDisturbButton {
          }

          #ExitButton {
          }

          #ClearNotificationsButton {
          }

          #NotificationsWindow {
          }

          .debugimage {
            border: solid 3px blue;
          }

          .Notification {
            padding: 10px;
            margin: 5px 0px 5px 0px;
            border: solid 2px #327cd5;
            border-radius: 5px;
          }

          .CloseNotificationButton {
            margin: 0px 5px 0px 10px;
          }
          .PictureButtonBox {
          }
          .BaseBox {
          }
            }
        '';
      };
    });
}
