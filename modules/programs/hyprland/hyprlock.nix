{
  config,
  lib,
  options,
  pkgs,
  ...
}: {
  options.mods = {
    hyprland.hyprlock = {
      enable = lib.mkOption {
        default = true;
        example = false;
        type = lib.types.bool;
        description = "Enables Hyprlock";
      };
    };
  };

  config = lib.mkIf config.mods.hyprland.hyprlock.enable (
    lib.optionalAttrs (options ? xdg.configFile) {
      stylix.targets.hyprlock = {
        enable = false;
      };
      home.packages = with pkgs; [hyprlock];
      programs.hyprlock = lib.mkIf config.mods.hyprland.hyprlock.enable {
        enable = true;
        settings = {
          background = [
            {
              monitor = "";
              path = "";
              color = "rgba(26, 27, 38, 1.0)";
            }
          ];

          input-field = [
            {
              monitor = "${config.conf.defaultMonitor}";

              placeholder_text = "password or something";
            }
          ];

          label = [
            {
              monitor = "${config.conf.defaultMonitor}";
              text = "$TIME";
              font_size = 50;
              position = "0, 200";
              valign = "center";
              halign = "center";
            }
          ];
        };
      };
    }
  );
}
