{
  additionalHomeConfig,
  additionalHomeMods,
  additionalInputs,
  config,
  homeMods,
  inputs,
  lib,
  mod,
  pkgs,
  root,
  alternativePkgs,
  ...
}: {
  xdg = {
    portal.config.common.default = "*";
    portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs root additionalInputs alternativePkgs;
    };

    users.${config.conf.username} = {
      imports =
        [
          ./common.nix
          ./themes
          ./sync.nix
        ]
        ++ homeMods
        ++ additionalHomeMods
        ++ lib.optional (builtins.pathExists mod) mod
        ++ lib.optional (builtins.pathExists additionalHomeConfig) additionalHomeConfig;
    };
  };
}
