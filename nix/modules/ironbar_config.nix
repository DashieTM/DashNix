{ lib, ... }: {
  options.programs.ironbar = {
    monitor = lib.mkOption {
      default = "";
      example = "eDP-1";
      type = lib.types.str;
      description = ''
        Extra settings for foo.
      '';
    };

    battery = lib.mkOption {
      default = [];
      example = [];
    };
  };
}
