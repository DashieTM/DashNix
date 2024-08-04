{ inputs, pkgs, ... }: {
  build_systems = systems: builtins.listToAttrs (map
    (name: {
      name = name;
      value =
        let
          mod = ../hardware/${name}/configuration.nix;
        in
        inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs pkgs mod;
          };
          modules = [
            inputs.home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix
            ../base
            ../programs
            mod
          ] ++ inputs.nixpkgs.lib.optional (builtins.pathExists ../hardware/${name}/${name}.nix) ../hardware/${name}/${name}.nix
          ++ inputs.nixpkgs.lib.optional (builtins.pathExists mod) mod;
        };
    })
    systems);
}
