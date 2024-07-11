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
      dashielib = import ./lib { inherit inputs pkgs; };
    in
    {
      nixosConfigurations = (dashielib.build_systems [ "marmo" "overheating" "spaceship" ]);
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
