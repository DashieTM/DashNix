{ inputs, pkgs, mod, ... }:
let
  base_imports = [
    inputs.anyrun.homeManagerModules.default
    inputs.ironbar.homeManagerModules.default
    inputs.oxicalc.homeManagerModules.default
    inputs.oxishut.homeManagerModules.default
    inputs.oxinoti.homeManagerModules.default
    inputs.oxidash.homeManagerModules.default
    inputs.oxipaste.homeManagerModules.default
    inputs.hyprdock.homeManagerModules.default
    inputs.hyprland.homeManagerModules.default
    inputs.reset.homeManagerModules.default
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    inputs.sops-nix.homeManagerModules.sops
  ];
in
{
  xdg.portal.config.common.default = "*";
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.dashie = {
    imports = [
      {
        _module = { args = { inherit inputs; }; };
      }
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
      mod
    ] ++ base_imports;
  };
}
