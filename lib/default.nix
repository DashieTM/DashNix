{ inputs, pkgs, ... }:
let
in {
  build_systems = systems: root:
    builtins.listToAttrs (map (name: {
      name = name;
      value = let
        mod = root + /${name}/configuration.nix;
        additionalConfig = root + /${name}/${name}.nix;
      in inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs pkgs mod; };
        modules = [
          inputs.home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          ../base
          ../programs
          ../modules
          mod
        ] ++ inputs.nixpkgs.lib.optional (builtins.pathExists additionalConfig)
          additionalConfig
          ++ inputs.nixpkgs.lib.optional (builtins.pathExists mod) mod;
      };
    }) systems);
}
