{
  description = "Dashie dots";

  inputs =
    {
      nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";

      nix-flatpak = {
        url = "github:gmodena/nix-flatpak";
      };

      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

      hyprlock.url = "github:hyprwm/hyprlock";

      Hyprspace = {
        url = "github:KZDKM/Hyprspace";
        inputs.hyprland.follows = "hyprland";
      };

      ironbar = {
        url = "github:JakeStanger/ironbar";
      };

      rust-overlay = {
        url = "https://github.com/oxalica/rust-overlay/archive/master.tar.gz";
      };

      anyrun.url = "github:Kirottu/anyrun";
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
      nixosConfigurations."marmo" = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs pkgs;
          mod = ./hardware/marmo/base_config.nix;
        };
        modules = [
          ./hardware/marmo/default.nix
          ./programs/gaming/default.nix
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
