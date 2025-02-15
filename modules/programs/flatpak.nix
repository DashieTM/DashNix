{
  lib,
  config,
  options,
  pkgs,
  ...
}: {
  options.mods.flatpak = {
    enable = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Enables the flatpak package manager";
    };
    additional_packages = lib.mkOption {
      default = [];
      example = [];
      type = with lib.types; listOf str;
      description = "Flatpak packages";
    };
  };
  config = lib.mkIf config.mods.flatpak.enable (
    lib.optionalAttrs (options ? services.flatpak.remote) {
      environment.systemPackages = [pkgs.flatpak];
      services.flatpak.remotes = lib.mkOptionDefault [
        {
          name = "flathub-stable";
          location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }
      ];
      services.flatpak.uninstallUnmanaged = true;
    }
    // lib.optionalAttrs (options ? services.flatpak.packages) {
      services.flatpak.packages =
        [
          # fallback if necessary, but generally avoided as nix is superior :)
          # default flatseal installation since flatpak permissions are totally not a broken idea
          "com.github.tchx84.Flatseal"
        ]
        ++ config.mods.flatpak.additional_packages;
    }
  );
}
