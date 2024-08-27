{
  inputs,
  pkgs,
  config,
  lib,
  mod,
  additionalHomeConfig,
  homeMods,
  root,
  ...
}:
{
  xdg = {
    portal.config.common.default = "*";
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs root;
    };

    users.${config.conf.username} = {
      imports =
        [
          ./common.nix
          ./xdg.nix
          ./themes
          ./sync.nix
        ]
        ++ homeMods
        ++ lib.optional (builtins.pathExists mod) mod
        ++ lib.optional (builtins.pathExists additionalHomeConfig) additionalHomeConfig;
    };
  };
}
