{ inputs
, lib
, config
, pkgs
, ...
}:
let
  regreet_override = pkgs.greetd.regreet.overrideAttrs (final: prev: {
    SESSION_DIRS = "${config.services.xserver.displayManager.sessionData.desktops}/share";
  });
  session = {
    command = "${lib.getExe pkgs.hyprland} --config /etc/greetd/hyprgreet.conf";
    user = "dashie";
  };
in
{
  imports = [
    inputs.hyprland.nixosModules.default
  ];

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

    monitor=${config.programs.ironbar.monitor},3440x1440@180,0x0,1
    monitor=_,disable

    input {
        force_no_accel = true
    }

    misc {
        disable_splash_rendering = true
        disable_hyprland_logo = true
    }

    exec-once=regreet --style /home/dashie/.config/gtk-3.0/gtk.css; hyprctl dispatch exit
  '';

  # unlock GPG keyring on login
  security.pam.services.greetd.enableGnomeKeyring = true;
}
