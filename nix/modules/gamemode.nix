{ lib, ... }: {
  options.programs.gamemode = {
    device = lib.mkOption {
      default = 0;
      example = 0;
      description = ''
        GPU device number
      '';
    };
  };
}
