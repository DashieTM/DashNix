{
  lib,
  config,
  options,
  ...
}: {
  options.mods.git = {
    username = lib.mkOption {
      default = "DashieTM";
      example = "globi";
      type = lib.types.str;
      description = "Git user name";
    };
    email = lib.mkOption {
      default = "fabio.lenherr@gmail.com";
      example = "globi@globus.glob";
      type = lib.types.str;
      description = "Git email";
    };
    additionalConfig = lib.mkOption {
      default = {
        merge = {
          tool = "nvimdiff";
        };
        diff = {
          tool = "nvimdiff";
        };
        pull.rebase = true;
      };
      example = {
        pull.rebase = false;
      };
      type = with lib.types; attrsOf anything;
      description = "Additional git config";
    };
    sshConfig = lib.mkOption {
      default = ''
        Host github.com
          ${
          if (config ? sops.secrets && config.sops.secrets ? hub.path)
          then "IdentityFile ${config.sops.secrets.hub.path}"
          else ""
        }
        Host gitlab.com
          ${
          if (config ? sops.secrets && config.sops.secrets ? lab.path)
          then "IdentityFile ${config.sops.secrets.lab.path}"
          else ""
        }
        Host dashie.org
          ${
          if (config ? sops.secrets && config.sops.secrets ? dashie.path)
          then "IdentityFile ${config.sops.secrets.dashie.path}"
          else ""
        }
      '';
      example = "";
      type = lib.types.lines;
      description = "ssh configuration (keys for git)";
    };
  };
  config = (
    lib.optionalAttrs (options ? programs.git && options ? home.file) {
      programs.git = {
        enable = true;
        userName = config.mods.git.username;
        userEmail = config.mods.git.email;
        extraConfig = config.mods.git.additionalConfig;
      };
      home.file.".ssh/config".text = config.mods.git.sshConfig;
    }
  );
}
