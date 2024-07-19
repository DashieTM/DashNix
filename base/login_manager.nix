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

  environment.etc."greetd/hyprgreet.conf".text = ''
    exec-once=gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

    monitor=${config.conf.monitor},3440x1440@180,0x0,${config.conf.scale}
    monitor=_,disable

    input {
        force_no_accel = true
    }

    misc {
        disable_splash_rendering = true
        disable_hyprland_logo = true
    }

    exec-once=regreet --style /home/${username}/.config/gtk-3.0/gtk.css; hyprctl dispatch exit
  '';

  # unlock GPG keyring on login
  security.pam.services.greetd.enableGnomeKeyring = true;
}
