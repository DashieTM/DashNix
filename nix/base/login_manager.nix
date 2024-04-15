{pkgs,
  config,
  lib,
  ...
}: {
  # greetd display manager
  services.greetd = let
    session = {
      command = "${pkgs.hyprland}/bin/Hyprland --config /home/dashie/.config/hypr/hyprgreet.conf";
      user = "dashie";
    };
  in {
    enable = true;
    settings = {
      terminal.vt = 1;
      default_session = session;
      initial_session = session;
    };
  };
  programs.regreet.enable = true;

  # unlock GPG keyring on login
  security.pam.services.greetd.enableGnomeKeyring = true;
}
