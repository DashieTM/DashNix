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

      # Hyprspace = {
      #   url = "github:KZDKM/Hyprspace";
      #   inputs.hyprland.follows = "nixpkgs";
      # };

      nur.url = "github:nix-community/nur";
      hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

      ironbar = {
        url = "github:JakeStanger/ironbar";
      };

      stylix.url = "github:danth/stylix";

      anyrun.url = "github:Kirottu/anyrun";
      oxicalc.url = "github:DashieTM/OxiCalc";
      oxishut.url = "github:DashieTM/OxiShut";
      oxinoti.url = "github:DashieTM/OxiNoti";
      oxidash.url = "github:DashieTM/OxiDash";
      oxipaste.url = "github:DashieTM/OxiPaste";
      hyprdock.url = "github:DashieTM/hyprdock";
      reset.url = "github:Xetibo/ReSet";
      reset-plugins.url = "github:Xetibo/ReSet-Plugins";
    };

  outputs = { ... }@inputs:
    let
      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        overlays = [
          inputs.nur.overlay
          # DUDE FOR FUCK SAKE
          # https://github.com/NixOS/nixpkgs/pull/325825 ....
          # fucking fun 
          # TODO: https://github.com/NixOS/nixpkgs/pull/325825 ....
          (_: prev: {
            python312 = prev.python312.override { packageOverrides = _: pysuper: { nose = pysuper.pynose; }; };
          })
        ];
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations = (builtins.listToAttrs (map
        (name: {
          name = name;
          value =
            let
              mod = ./hardware/${name}/configuration.nix;
            in
            inputs.nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit inputs pkgs mod;
              };
              modules = [
                inputs.home-manager.nixosModules.home-manager
                inputs.stylix.nixosModules.stylix
                ./base/default.nix
                ./programs
                mod
              ] ++ inputs.nixpkgs.lib.optional (builtins.pathExists ./hardware/${name}/${name}.nix) ./hardware/${name}/${name}.nix
              ++ inputs.nixpkgs.lib.optional (builtins.pathExists mod) mod;
            };
        }) [ "marmo" "overheating" "spaceship" ]));
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
