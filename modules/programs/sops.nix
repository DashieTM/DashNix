{
  lib,
  pkgs,
  config,
  options,
  root,
  ...
}:
{
  options.mods.sops = {
    enable = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Enable sops secrets";
    };
    secrets = lib.mkOption {
      default = { };
      example = {
        hub = { };
        lab = { };
        ${config.conf.username} = { };
        nextcloud = { };
        access = { };
      };
      type = with lib.types; attrsOf anything;
      description = "secrets for sops";
    };
    sopsPath = lib.mkOption {
      default = root + /secrets/secrets.yaml;
      example = "/your/path";
      type =
        with lib.types;
        oneOf [
          string
          path
        ];
      description = "sops secrets path";
    };
    validateSopsFile = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Whether to validate the sops file -> set this to false when using full paths";
    };
  };
  config = lib.mkIf config.mods.sops.enable (
    lib.optionalAttrs (options ? home.packages) {
      home.packages = with pkgs; [ sops ];
      sops = {
        gnupg = {
          home = "~/.gnupg";
          sshKeyPaths = [ ];
        };
        defaultSopsFile = config.mods.sops.sopsPath;
        validateSopsFiles = config.mods.sops.validateSopsFile;
        secrets = config.mods.sops.secrets;
      };

      systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
    }
  );
}
