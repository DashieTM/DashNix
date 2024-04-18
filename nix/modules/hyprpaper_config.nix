{ lib, ... }: {
  options.programs.hyprland = {
    hyprpaper = lib.mkOption {
      default = '''';
      example = ''
        hyprpaper stuff
      '';
      type = lib.types.lines;
      description = ''
        Extra settings for foo.
      '';
    };
  };
}
