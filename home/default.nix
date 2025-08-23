{
  mkDashDefault,
  additionalHomeConfig,
  additionalHomeMods,
  additionalInputs,
  dashNixAdditionalProps,
  config,
  homeMods,
  inputs,
  lib,
  mod,
  pkgs,
  root,
  alternativePkgs,
  system,
  stable,
  unstable,
  ...
}: {
  xdg = {
    portal.config.common = {
      default = mkDashDefault "hyprland;gtk";
      "org.freedesktop.impl.portal.FileChooser" = lib.mkIf (config.mods.media.filePickerPortal != "Default") "shana";
    };
    portal = {
      enable = mkDashDefault true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk # prob needed either way
        (lib.mkIf (config.mods.media.filePickerPortal != "Default") xdg-desktop-portal-shana)
        (lib.mkIf (config.mods.media.filePickerPortal == "Kde") kdePackages.xdg-desktop-portal-kde)
        # Gnome uses their file manager, kinda cool tbh
        (lib.mkIf (config.mods.media.filePickerPortal == "Gnome" && !config.mods.nautilus.enable) nautilus)
        (lib.mkIf (config.mods.media.filePickerPortal == "Lxqt") xdg-desktop-portal-lxqt)
        (lib.mkIf (config.mods.media.filePickerPortal == "Term") xdg-desktop-portal-termfilechooser)
      ];
    };
  };
  home-manager = {
    useGlobalPkgs = mkDashDefault true;
    useUserPackages = mkDashDefault true;
    extraSpecialArgs = {
      inherit
        inputs
        root
        additionalInputs
        alternativePkgs
        system
        stable
        unstable
        dashNixAdditionalProps
        ;
      mkDashDefault = import ../lib/override.nix {inherit lib;};
    };

    users.${config.conf.username} = {
      disabledModules = ["programs/anyrun.nix"];
      imports =
        [
          ./common.nix
          ./themes
          ./sync.nix
          ../lib/foxwrappers.nix
        ]
        ++ homeMods
        ++ additionalHomeMods
        ++ lib.optional (builtins.pathExists mod) mod
        ++ lib.optional (builtins.pathExists additionalHomeConfig) additionalHomeConfig;
    };
  };
}
