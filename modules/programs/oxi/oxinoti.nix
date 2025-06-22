{
  lib,
  config,
  options,
  pkgs,
  inputs,
  ...
}: let
  # at time of using this here, stylix might not be evaluated yet
  # hence ensure it is by using base16 mkSchemeAttrs
  base16 = pkgs.callPackage inputs.base16.lib {};
  scheme = base16.mkSchemeAttrs config.stylix.base16Scheme;
in {
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
            @import url("/home/dashie/.config/gtk-3.0/gtk.css");

            @define-color bg #${scheme.base00};
            @define-color bghover #${scheme.base02};
            @define-color primary #${scheme.base0D};
            @define-color red #${scheme.base08};
            @define-color green #${scheme.base0B};

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
              background-color: @bg;
              border-radius: 5px;
              border: solid 1px;
              margin: 0px;
            }

            .NotificationBox button {
              background-color: @bg;
            }

            .NotificationBox button:hover {
              background-color: @bghover;
            }

            .NotificationLow {
              border-color: @green;
            }

            .NotificationNormal {
              border-color: @primary;
            }

            .NotificationUrgent {
              border-color: @red;
            }

            .miscbox {
              margin: 0px 10px 0px 0px;
            }

            .bodybox {}

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

            .image {}

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
