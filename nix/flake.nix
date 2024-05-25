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

      sops-nix.url = "github:Mic92/sops-nix";

      Hyprspace = {
        url = "github:KZDKM/Hyprspace";
        # Hyprspace uses latest Hyprland. We declare this to keep them in sync.
        inputs.hyprland.follows = "nixpkgs";
      };

      nur.url = "github:nix-community/nur";
      # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      # hyprland.url = "git+https://github.com/hyprwm/Hyprland?rev=2f1735bd93adb9e153758cd4171d8fd3ae610357";
      # hyprland.url = "github:hyprwm/Hyprland/xwayland-rewrite?submodules=1";

      ironbar = {
        url = "github:JakeStanger/ironbar";
      };

      anyrun.url = "github:Kirottu/anyrun";
      oxicalc.url = "github:DashieTM/OxiCalc";
      oxishut.url = "github:DashieTM/OxiShut";
      oxinoti.url = "github:DashieTM/OxiNoti";
      oxidash.url = "github:DashieTM/OxiDash";
      oxipaste.url = "github:DashieTM/OxiPaste";
      hyprdock.url = "github:DashieTM/hyprdock";
      reset.url = "github:Xetibo/ReSet";
    };

  outputs = { ... }@inputs:
    let
      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        overlays = [
          inputs.nur.overlay
        ];
        config = {
          allowUnfree = true;
        };
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
