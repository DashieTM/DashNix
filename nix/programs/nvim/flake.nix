{
  description = "Dashies neovim config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };
  outputs =
    { ...
    }@inputs:
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
    in
    {
      imports = [ ./default.nix { inherit pkgs; } ];
    };
}
