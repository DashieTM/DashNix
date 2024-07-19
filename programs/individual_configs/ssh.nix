{ config, ... }: {
  home.file.".ssh/config".text = ''
    Host github.com
      IdentityFile ${config.sops.secrets.hub.path}
    Host gitlab.com
      IdentityFile ${config.sops.secrets.lab.path}
    Host dashie.org
      IdentityFile ${config.sops.secrets.dashie.path}
  '';
}
