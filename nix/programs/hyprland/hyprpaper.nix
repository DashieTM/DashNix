{ config, ... }: {
  xdg.configFile."hypr/hyprpaper.conf" = {
    text = config.conf.hyprland.hyprpaper;
  };
}
