{ lib, ... }: {
  options.programs.ironbar = {
    monitor = lib.mkOption {
      default = "";
      example = "eDP-1";
      type = lib.types.str;
      description = ''
        main monitor
      '';
    };
    scale = lib.mkOption {
      default = "1.0";
      example = "1.0";
      type = lib.types.str;
      description = ''
        Scale for the monitor
      '';
    };

    battery = lib.mkOption {
      default = [ ];
      example = [ ];
    };
  };
}
