{ lib, pkgs, config, options, root, ... }: {
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
  };
  config = lib.mkIf config.mods.sops.enable
    (lib.optionalAttrs (options ? home.packages) {
      home.packages = with pkgs; [ sops ];
      sops = {
        gnupg = {
          home = "~/.gnupg";
          sshKeyPaths = [ ];
        };
        defaultSopsFile = root + /secrets/secrets.yaml;
        secrets = config.mods.sops.secrets;
      };

      systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
    });
}
