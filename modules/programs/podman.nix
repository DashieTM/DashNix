{
  lib,
  config,
  options,
  pkgs,
  ...
}:
{
  options.mods.podman = {
    enable = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Enables and configures podman";
    };
  };
  config = lib.mkIf config.mods.podman.enable (
    lib.optionalAttrs (options ? virtualisation.podman) {
      environment.systemPackages = with pkgs; [
        podman-tui
        podman-compose
        dive
      ];
      virtualisation = {
        containers.enable = true;
        podman = {
          enable = true;
          dockerCompat = true;
          defaultNetwork.settings.dns_enabled = true;
        };
      };
    }
  );
}
