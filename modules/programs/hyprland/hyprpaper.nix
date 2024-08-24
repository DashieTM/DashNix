{ config, lib, options, pkgs, ... }: {
  options.mods = {
    hyprland.hyprpaper = {
      enable = lib.mkOption {
        default = true;
        example = false;
        type = lib.types.bool;
        description = "Enables Hyprpaper";
      };
      config = lib.mkOption {
        default = "";
        example = ''
          Hyprpaper config
        '';
        type = lib.types.lines;
        description = ''
          Hyprpaper config
        '';
      };
    };
  };

  config = lib.mkIf config.mods.hyprland.hyprpaper.enable
    (lib.optionalAttrs (options ? xdg.configFile) {
      home.packages = with pkgs; [ hyprpaper ];
      xdg.configFile."hypr/hyprpaper.conf" =
        lib.mkIf config.mods.hyprland.hyprpaper.enable {
          text = config.mods.hyprland.hyprpaper.config;
        };
    });
}
