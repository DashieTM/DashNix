{ inputs, pkgs, config, lib, mod, ... }:
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
    inputs.dashvim.homeManagerModules.dashvim
    ../modules
  ];
in {
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
    extraSpecialArgs = { inherit inputs; };

    users.${config.conf.username} = {
      imports = [
        ./common.nix
        ./xdg.nix
        ./oxi/default.nix
        ./themes/default.nix
        ./sync.nix
      ] ++ base_imports ++ lib.optional (builtins.pathExists mod) mod;
    };
  };
}
