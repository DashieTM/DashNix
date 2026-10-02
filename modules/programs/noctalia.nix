{
  mkDashDefault,
  lib,
  config,
  options,
  ...
}: let
  cfg = config.mods.noctalia;
in {
  options.mods.noctalia = {
    enable = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Enables Noctalia. Only active when mods.wm.suite is \"noctalia\".";
    };
    settings = lib.mkOption {
      default = {};
      example = {
        settings_show_advanced = true;
      };
      type = with lib.types; attrsOf anything;
      description = "Additional Noctalia settings. The theme (palette, font, wallpaper, opacity) is provided by stylix from the dashnix colorscheme, and the bar clock defaults to the palette accent (overridable via settings.widget.clock.color).";
    };
    customPalettes = lib.mkOption {
      default = {};
      example = {};
      type = with lib.types; attrsOf anything;
      description = "Additional custom Noctalia palettes, available alongside the stylix-generated one.";
    };
    systemd = {
      enable = lib.mkOption {
        default = false;
        example = true;
        type = lib.types.bool;
        description = "Start Noctalia via systemd user service instead of compositor autostart.";
      };
    };
  };

  # This module is evaluated in both NixOS and Home Manager scopes, which
  # provide different `programs.noctalia` options: the upstream home module
  # offers `settings`/`customPalettes`, while the nixpkgs NixOS module only
  # offers system integration. Gate each side on the options it supports,
  # mirroring the `options ? ...` pattern used by the oxi modules.
  #
  # Theming intentionally goes through the stylix noctalia target, which
  # derives its palette from the same stylix.base16Scheme (including the
  # dashnix accent override), so the shell follows the dashnix theme.
  config = let
    hmNoctalia = lib.optionalAttrs (options ? programs.noctalia.settings) {
      programs.noctalia = {
        enable = true;
        systemd.enable = cfg.systemd.enable;
        # The bar clock follows the palette accent automatically. The
        # stylix palette derives `primary` from the dashnix colorscheme
        # (including the accentColor override), so this tracks it with no
        # further config. Plain user values win over mkDashDefault.
        settings =
          if builtins.isAttrs cfg.settings
          then
            lib.mkMerge [
              {widget.clock.color = mkDashDefault "primary";}
              cfg.settings
            ]
          else cfg.settings;
        inherit (cfg) customPalettes;
      };
    };
    nixosNoctalia = lib.optionalAttrs (options ? programs.noctalia.recommendedServices) {
      # Noctalia widgets expect NetworkManager, bluetooth, UPower and a
      # power profile daemon; defaults stay overridable.
      programs.noctalia.recommendedServices.enable = mkDashDefault true;
    };
  in
    lib.mkIf (cfg.enable && config.mods.wm.suite == "noctalia") (
      hmNoctalia // nixosNoctalia
    );
}
