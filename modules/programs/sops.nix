{ lib, pkgs, config, options, ... }: {
  options.mods.sops = {
    enable = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Enable sops secrets";
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
        defaultSopsFile = ../../secrets/secrets.yaml;
        secrets = {
          hub = { };
          lab = { };
          ${config.conf.username} = { };
          nextcloud = { };
          access = { };
        };
      };

      systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
    });
}
