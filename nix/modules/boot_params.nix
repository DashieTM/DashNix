{ lib, ... }: {
  options.programs.boot = {
    boot_params = lib.mkOption {
      default = [ ];
      example = [ "resume=something" ];
      description = ''
        Boot params
      '';
    };
  };
}
