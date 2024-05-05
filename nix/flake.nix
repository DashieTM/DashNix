{
  description = "Dashie dots";

  inputs =
    {
      nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
      nix-flatpak = {
        url = "github:gmodena/nix-flatpak";
        #inputs.nixpkgs.follows = "nixpkgs";
      };
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      # inputs.nixpkgs.follows = "nixpkgs";
      Hyprspace = {
        url = "github:KZDKM/Hyprspace";
        inputs.hyprland.follows = "hyprland";
      };
      ironbar = {
        url = "github:JakeStanger/ironbar";
        # inputs.nixpkgs.follows = "nixpkgs";
      };
      rust-overlay = {
        url = "https://github.com/oxalica/rust-overlay/archive/master.tar.gz";
        # inputs.nixpkgs.follows = "nixpkgs";
      };
      anyrun.url = "github:Kirottu/anyrun";
      # inputs.nixpkgs.follows = "nixpkgs";
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
          (import
            inputs.rust-overlay
          )
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
        ] ++ base_imports;
      };
      nixosConfigurations."overheating" = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs pkgs;
          mod = ./hardware/overheating/base_config.nix;
        };
        modules = [
          ./hardware/overheating/default.nix
        ] ++ base_imports;
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

  nixConfig = {
    builders-use-substitutes = true;
    # substituters to use
    extra-substituters = [
      "https://hyprland.cachix.org"
      "https://anyrun.cachix.org"
    ];

    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
    ];
  };
}
