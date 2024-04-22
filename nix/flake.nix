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

  outputs = { ... }@inputs:
    let
      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
        };
        overlays = [
          # because allowing rust nightly is too hard by default....
          (import (fetchTarball {
            url = "https://github.com/oxalica/rust-overlay/archive/master.tar.gz";
            sha256 = "sha256:02p0zzglgi3980iyam46wv8ajr83wj6myjhrjjfv96vkafl6pycg";
          }))
        ];
      };
      base_imports = [
        inputs.home-manager.nixosModules.home-manager
        ./base/default.nix
        ./programs
      ];
    in
    {
      homeConfigurations."marmo" = inputs.home-manager.lib.homeManagerConfiguration {
        specialArgs = {
          inherit inputs pkgs;
          mod = ./hardware/overheating/base_config.nix;
        };
        modules = [
          ./hardware/marmo/default.nix
        ];
      };
      nixosConfigurations."overheating" = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs pkgs;
          mod = ./hardware/overheating/base_config.nix;
        };
        modules = [
          ./hardware/overheating/default.nix
        ];
      };
      nixosConfigurations."spaceship" = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs pkgs;
          mod = ./hardware/spaceship/base_config.nix;
        };
        modules = [
          ./hardware/spaceship/default.nix
          ./hardware/streamdeck.nix
          ./programs/gaming/default.nix
        ] ++ base_imports;
      };
    };
}
