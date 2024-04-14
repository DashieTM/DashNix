{
  description = "Dashie dots";

  inputs =
    {
      flatpaks.url = "github:GermanBread/declarative-flatpak/stable";
      nixpkgs.url = "github:nixos/nixpkgs";
	home-manager = {
	url = "github:nix-community/home-manager/release-23.05";
	inputs.nixpkgs.follows = "nixpkgs";
    };
   hyprland.url = "github:hyprwm/Hyprland";
    };

  outputs = { self, nixpkgs, home-manager, flatpaks, hyprland }:
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
      homeConfigurations."dashie" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
   	flatpaks.homeManagerModules.default 
        hyprland.homeManagerModules.default
	./programs/hyprland/config.nix
	];
      };

      nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        modules = [
	  ./configuration.nix
   	flatpaks.nixosModules.default 
        hyprland.nixosModules.default
	  home-manager.nixosModules.home-manager {
	  home-manager.users.dashie = import ./programs/default.nix {inherit pkgs; };
	  home-manager.useGlobalPkgs = true;
	  }
	./programs/flatpak.nix
        ];
      };
    };
}
