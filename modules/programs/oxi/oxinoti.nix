{
  lib,
  config,
  options,
  ...
}: {
  options.mods.oxi.oxinoti = {
    enable = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Enables and configures oxinoti";
    };
  };
  config = lib.mkIf (config.mods.oxi.oxinoti.enable && config.mods.oxi.enable) (
    lib.optionalAttrs (options ? xdg.configFile) {
      programs.oxinoti.enable = true;
      xdg.configFile."oxinoti/style.css" = {
        text =
          # css
          ''
            @import url("/home/${config.conf.username}/.config/gtk-3.0/gtk.css");

            #MainWindow {
              background-color: transparent;
              padding: 0px;
              /* opacity: 0; */
            }

            .MainBox {
              background-color: transparent;
              padding: 0px;
              /* opacity: 0; */
            }

            .NotificationBox {
              background-color: #353747;
              border-radius: 5px;
              border: solid 1px;
              margin: 0px;
              padding: 5px;
            }

            .NotificationLow {
              border-color: green;
            }

            .NotificationNormal {
              border-color: purple;
            }

            .NotificationUrgent {
              border-color: red;
            }

            .miscbox {
              margin: 0px 10px 0px 0px;
            }

            .bodybox {
            }

            .imagebox {
              margin: 0px 0px 0px 10px;
            }

            .appname {
              font-size: 0.8rem;
            }

            .timestamp {
              font-size: 0.8rem;
            }

            .summary {
              font-size: 0.8rem;
            }

            .body {
              font-size: 1.2rem;
            }

            .icon {
              font-size: 2rem;
            }

            .image {
            }

            .bold {
              font-weight: bold;
            }

            .italic {
              font-style: italic;
            }

            .underline {
              text-decoration-line: underline;
            }
          '';
      };
      xdg.configFile."oxinoti/oxinoti.toml" = {
        text = ''
          timeout = 3
          dnd_override = 2
        '';
      };
    }
  );
}
