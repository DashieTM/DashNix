{
  lib,
  config,
  options,
  pkgs,
  ...
}:
{
  # TODO make exclusive with docker
  options.mods.docker = {
    enable = lib.mkOption {
      default = false;
      example = false;
      type = lib.types.bool;
      description = "Enables and configures docker";
    };
  };
  config = lib.mkIf config.mods.docker.enable (
    lib.optionalAttrs (options ? virtualisation.docker) {
      environment.systemPackages = with pkgs; [
        docker-compose
        dive
      ];
      virtualisation = {
        containers.enable = true;
        docker = {
          enable = true;
        };
      };
    }
  );
}
