{ inputs, pkgs, ... }:
let
in {
  build_systems = systems: root:
    builtins.listToAttrs (map (name: {
      name = name;
      value = let
        mod = root + /${name}/configuration.nix;
        additionalNixosConfig = root + /${name}/hardware.nix;
        additionalHomeConfig = root + /${name}/home.nix;
      in inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs pkgs mod additionalHomeConfig; };
        modules = [
          inputs.home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          ../base
          ../home
          ../modules
          mod
        ] ++ inputs.nixpkgs.lib.optional
          (builtins.pathExists additionalNixosConfig) additionalNixosConfig
          ++ inputs.nixpkgs.lib.optional (builtins.pathExists mod) mod;
      };
    }) systems);
}
