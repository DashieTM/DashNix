{
  description = "A lazyvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        { pkgs, ... }:
        let
          colorscheme = "catppuccin-mocha";
          dashieVimModule = {
            inherit pkgs colorscheme;
            module = import ./default.nix;
            nvim = pkgs.neovim;
          };
        in
        {
          packages = {
            default = dashieVimModule.nvim;
          };
        };
    };
}
