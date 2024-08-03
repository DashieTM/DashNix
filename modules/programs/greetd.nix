{ config, lib, inputs, pkgs, options, ... }: {
  options.mods = {
    greetd = {
      enable = lib.mkOption {
        default = true;
        example = false;
        type = lib.types.bool;
        description = ''
          Enables the greetd login manager.
        '';
      };
      monitor = lib.mkOption {
        default = "${config.conf.monitor}";
        example = "eDP-1";
        type = lib.types.str;
        description = ''
          main monitor for the login screen.
          By default the main monitor is used.
        '';
      };
      scale = lib.mkOption {
        default = "${config.conf.scale}";
        example = "1.5";
        type = lib.types.str;
        description = ''
          Scale used by the monitor in the login screen.
          By default the scale of the main monitor is used. 
        '';
      };
      resolution = lib.mkOption {
        default = "auto";
        example = "3440x1440@180";
        type = lib.types.str;
        description = ''
          Resolution/refreshrate used by the monitor in the login screen. 
        '';
      };
    };
  };

  config =
    let
      username = config.conf.username;
      session = {
        command = "${lib.getExe inputs.hyprland.packages.${config.conf.system}.hyprland} --config /etc/greetd/hyprgreet.conf";
        user = username;
      };
    in
    lib.mkIf config.mods.greetd.enable
      (lib.optionalAttrs (options?environment) {
        services.xserver.displayManager.session = [
          {
            manage = "desktop";
            name = "Hyprland";
            start = ''
              ${lib.getExe pkgs.hyprland} & waitPID=$!
            '';
          }
        ];

        # greetd display manager
        programs.hyprland.enable = true;
        services.greetd = {
          enable = true;
          settings = {
            terminal.vt = 1;
            default_session = session;
          };
        };

        environment.etc."greetd/environments".text = ''
          Hyprland
        '';

        # should technically be the same, but this is configured instead in order to provide a decent out of the box login experience.
        environment.etc."greetd/hyprgreet.conf".text = ''
          exec-once=gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

          monitor=${config.mods.greetd.monitor},${config.mods.greetd.resolution},0x0,${config.mods.greetd.scale}
          monitor=_,disable

          input {
              kb_layout = ${config.mods.xkb.layout}
              kb_variant = ${config.mods.xkb.variant}
              force_no_accel = true
          }

          misc {
              disable_splash_rendering = false
              disable_hyprland_logo = false
          }

          exec-once=regreet --style /home/${username}/.config/gtk-3.0/gtk.css; hyprctl dispatch exit
        '';

        # unlock GPG keyring on login
        security.pam.services.greetd.enableGnomeKeyring = true;
      });
}
