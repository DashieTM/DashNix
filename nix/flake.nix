{
  description = "Dashie dots";

  inputs =
    {
      nix-flatpak.url = "github:gmodena/nix-flatpak";
      nixpkgs.url = "github:nixos/nixpkgs";
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      hyprland = {
        url = "github:hyprwm/Hyprland/67f47fbdccd639502a76ccb3552a23df37f19ef8";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      Hyprspace = {
        url = "github:KZDKM/Hyprspace";
        inputs.hyprland.follows = "hyprland";
      };
      ironbar = {
        url = "github:JakeStanger/ironbar";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      anyrun.url = "github:Kirottu/anyrun";
      anyrun.inputs.nixpkgs.follows = "nixpkgs";
    };

  outputs = inputs @ { self, nixpkgs, home-manager, nix-flatpak, hyprland, anyrun, ironbar, ... }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      homeConfigurations."dashie@spaceship" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./hardware/spaceship.nix ];
      };
      homeConfigurations."dashie@overheating" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./hardware/overheating.nix ];
      };
      nixosConfigurations."spaceship" = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        modules = [

          # TODO put this into not gaming
          ./hardware/spaceship.nix
          ./configuration.nix
          ./programs/gaming/default.nix
          ./base/default.nix
          hyprland.nixosModules.default
          home-manager.nixosModules.home-manager
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
            home-manager.users.dashie.imports = [
              {
                _module = { args = { inherit self inputs; }; };
              }
              ./programs/default.nix
              hyprland.homeManagerModules.default
              anyrun.homeManagerModules.default
              ironbar.homeManagerModules.default
              ./programs/hyprland/default.nix #{inherit Hyprspace; }
              nix-flatpak.homeManagerModules.nix-flatpak
              ./programs/flatpak.nix
            ];

            home-manager.users.dashie.home.stateVersion = "24.05";
          }
        ];
      };
    };
}
