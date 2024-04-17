{ config, ... }: {
  xdg.configFile."hypr/hyprpaper.conf" = {
    text = config.programs.hyprland.hyprpaper;
  };
}
