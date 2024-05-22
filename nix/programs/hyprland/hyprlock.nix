{ pkgs
, inputs
, config
, ...
}:
{
  programs.hyprlock.enable = true;
  programs.hyprlock.settings = {
    backgrounds = [
      {
        monitor = "";
        path = "";
        color = "rgba(26, 27, 38, 1.0)";
      }
    ];

    input-fields = [
      {
        monitor = "${config.programs.ironbar.monitor}";

        placeholder_text = "password or something";
      }
    ];

    labels = [
      {
        monitor = "";
        text = "$TIME";
        font_size = 50;
        valign = "center";
        halign = "center";
      }
    ];
  };
}
