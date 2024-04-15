{ ... }: {
  xdg.configFile."hypr/hyprgreet.conf" = {
    text =
      ''
        exec-once=gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

        monitor=DP-1,3440x1440@180,0x0,1
        monitor=DP-2,disable
        monitor=HDMI-A-1,disable

        input {
            force_no_accel = true
        }

        misc {
            disable_splash_rendering = true
            disable_hyprland_logo = true
        }

        exec-once=regreet --style /home/dashie/.config/gtk-3.0/gtk.css; hyprctl dispatch exit
      '';
  };
}
