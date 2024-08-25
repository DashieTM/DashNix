{
  description = "some dots";

  inputs = {
    dashvim.url = "github:DashieTM/DashVim";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    ironbar.url =
      "github:JakeStanger/ironbar?ref=3a1c60442382f970cdb7669814b6ef3594d9f048";
    anyrun.url = "github:Kirottu/anyrun";
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    stable.url = "github:NixOs/nixpkgs/nixos-24.05";
    dashNix = {
      url = "github:DashieTM/DashNix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        stable.follows = "stable";
        dashvim.follows = "dashvim";
        hyprland.follows = "hyprland";
        ironbar.follows = "ironbar";
        anyrun.follows = "anyrun";
      };
    };
  };

  outputs = { ... }@inputs: {
    nixosConfigurations =
      (inputs.dashNix.dashNixLib.build_systems [ "example" ] ./.);
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
