{ inputs, pkgs, mod, ... }:
let
  base_imports = [
    inputs.hyprland.homeManagerModules.default
    inputs.anyrun.homeManagerModules.default
    inputs.ironbar.homeManagerModules.default
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    ./hyprland/default.nix
    ./flatpak.nix
    ./common.nix
    ./coding.nix
    ./xdg.nix
    ./media.nix
    ./utils.nix
    ./oxi/default.nix
    ./themes/default.nix
    ./individual_configs/default.nix
  ];
in
{
  xdg.portal.config.common.default = "*";
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.dashie.imports = [
    {
      _module = { args = { inherit inputs; }; };
    }
    mod
  ] ++ base_imports;
}
