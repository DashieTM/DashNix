{ config, ... }:
let
  username = config.conf.username;
in
{
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  fonts.fontconfig.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05";

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];

  home.sessionVariables = {
    GOROOT = "$HOME/.go";
  };

  home.keyboard = null;

  home.file.".local/share/flatpak/overrides/global".text = ''
    [Context]
    filesystems=xdg-config/gtk-3.0;xdg-config/gtk-4.0
  '';

  programs.nix-index =
    {
      enable = true;
      enableFishIntegration = true;
    };

  nix = {
    extraOptions = ''
      !include ${config.sops.secrets.access.path}
    '';
  };

  sops = {
    gnupg = {
      home = "~/.gnupg";
      sshKeyPaths = [ ];
    };
    defaultSopsFile = ../secrets/secrets.yaml;
    secrets.hub = { };
    secrets.lab = { };
    secrets.${username} = { };
    secrets.nextcloud = { };
    secrets.access = { };
  };

  systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
}
