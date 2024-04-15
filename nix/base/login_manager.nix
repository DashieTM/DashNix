{ pkgs
, ...
}: {
  # greetd display manager
  services.greetd =
    let
      session = {
        command = "${pkgs.hyprland}/bin/Hyprland --config /home/dashie/.config/hypr/hyprgreet.conf";
        user = "dashie";
      };
    in
    {
      enable = true;
      settings = {
        terminal.vt = 1;
        default_session = session;
        initial_session = session;
      };
    };
  programs.regreet = {
    enable = true;
    settings = {

      background = {
        fit = "Contain";
      };

      env = {
        QT_QPA_PLATFORMTHEME = "qt5ct";
        PATH = "/home/dashie/.cargo/bin:PATH";
      };

      GTK = {
        application_prefer_dark_theme = true;
        cursor_theme_name = "Adwaita";
        icon_theme_name = "Adwaita";
        theme_name = "adw-gtk3";

        command = {
          reboot = [ "systemctl" "reboot" ];

          poweroff = [ "systemctl" "poweroff" ];
        };
      };
    };
  };

  # unlock GPG keyring on login
  security.pam.services.greetd.enableGnomeKeyring = true;
}
