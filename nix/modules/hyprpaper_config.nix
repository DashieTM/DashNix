{ lib, ... }: {
  options.programs.hyprland = {
    hyprpaper = lib.mkOption {
      default = '''';
      example = ''
        hyprpaper stuff
      '';
      type = lib.types.lines;
      description = ''
        hyprpaper
      '';
    };
    extra_autostart = lib.mkOption {
      default = [ ];
      example = [ "your application" ];
      type = lib.types.listOf lib.types.str;
      description = ''
        Extra exec_once.
      '';
    };
  };
}
