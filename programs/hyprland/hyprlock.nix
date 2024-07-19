{ config
, ...
}:
{
  programs.hyprlock = {
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
          monitor = "${config.conf.monitor}";

          placeholder_text = "password or something";
        }
      ];

      label = [
        {
          monitor = "${config.conf.monitor}";
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
