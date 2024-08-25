{
  config,
  lib,
  options,
  ...
}:
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

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";

    sessionPath = [ "$HOME/.cargo/bin" ];

    sessionVariables = {
      GOROOT = "$HOME/.go";
    };

    keyboard = null;

    file.".local/share/flatpak/overrides/global".text = ''
      [Context]
      filesystems=xdg-config/gtk-3.0;xdg-config/gtk-4.0
    '';
  };

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  nix = {
    extraOptions = lib.mkIf (options ? config.sops.secrets.access.path) ''
      !include ${config.sops.secrets.access.path}
    '';
  };
}
