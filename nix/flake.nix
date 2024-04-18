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
      };
      base_imports = [
        inputs.home-manager.nixosModules.home-manager
        ./base/default.nix
      ];
    in
    #inputs.flake-parts.lib.mkFlake { inherit inputs; }
    {
      #imports = [
      #];
      #homeConfigurations."marmo" = inputs.home-manager.lib.homeManagerConfiguration {
      #  inherit pkgs;
      #  modules = [
      #    ./hardware/marmo/default.nix
      #    ./programs
      #  ];
      #};
      nixosConfigurations."overheating" = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs pkgs;
          mod = ./hardware/overheating/base_config.nix;
        };
        modules = [
          ./hardware/overheating/default.nix
          ./programs
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
          ./programs
        ] ++ base_imports;
      };
    };
}
