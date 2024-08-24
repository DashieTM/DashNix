{
  description = "Dashie dots";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    stable.url = "github:NixOs/nixpkgs/nixos-24.05";

    nix-flatpak = { url = "github:gmodena/nix-flatpak"; };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";

    # Hyprspace = {
    #   url = "github:KZDKM/Hyprspace";
    #   inputs.hyprland.follows = "nixpkgs";
    # };

    nur.url = "github:nix-community/nur";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    ironbar = {
      url =
        "github:JakeStanger/ironbar?ref=3a1c60442382f970cdb7669814b6ef3594d9f048";
    };

    stylix.url = "github:danth/stylix";
    base16.url = "github:SenchoPens/base16.nix";

    anyrun.url = "github:Kirottu/anyrun";
    oxicalc.url = "github:DashieTM/OxiCalc";
    oxishut.url = "github:DashieTM/OxiShut";
    oxinoti.url = "github:DashieTM/OxiNoti";
    oxidash.url = "github:DashieTM/OxiDash";
    oxipaste.url = "github:DashieTM/OxiPaste";
    hyprdock.url = "github:DashieTM/hyprdock";
    reset.url = "github:Xetibo/ReSet";
    reset-plugins.url = "github:Xetibo/ReSet-Plugins";

    dashvim = {
      url = "github:DashieTM/DashVim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.base16.follows = "base16";
    };
  };

  outputs = { ... }@inputs:
    let
      stable = import inputs.stable {
        system = "x86_64-linux";
        config = { allowUnfree = true; };
      };
      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        overlays = [ inputs.nur.overlay ];
        config = {
          permittedInsecurePackages = [ "olm-3.2.16" ];
          allowUnfree = true;
        };
      };
    in {
      dashNixLib = import ./lib { inherit inputs pkgs; };
      dashNixInputs = inputs;
      stablePkgs = stable;
      unstablePkgs = pkgs;
      modules = ./modules;
    };

  nixConfig = {
    builders-use-substitutes = true;

    extra-substituters = [
      "https://hyprland.cachix.org"
      "https://anyrun.cachix.org"
      "https://cache.garnix.io"
    ];

    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
  };
}
