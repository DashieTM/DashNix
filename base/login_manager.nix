{ lib
, config
, pkgs
, inputs
, ...
}:
let
  username = config.conf.username;
  session = {
    command = "${lib.getExe inputs.hyprland.packages.${config.conf.system}.hyprland} --config /etc/greetd/hyprgreet.conf";
    user = username;
  };
in
{
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

    monitor=${config.conf.login_manager.monitor},${config.conf.login_manager.resolution},0x0,${config.conf.login_manager.scale}
    monitor=_,disable

    input {
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
}
