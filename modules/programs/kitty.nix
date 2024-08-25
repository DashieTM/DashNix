{
  lib,
  config,
  options,
  pkgs,
  inputs,
  ...
}:
let
  base16 = pkgs.callPackage inputs.base16.lib { };
  scheme = (base16.mkSchemeAttrs config.stylix.base16Scheme);
  hexTable = {
    "0" = "1";
    "1" = "0";
    "2" = "1";
    "3" = "2";
    "4" = "3";
    "5" = "4";
    "6" = "5";
    "7" = "6";
    "8" = "7";
    "9" = "8";
    "a" = "9";
    "b" = "a";
    "c" = "b";
    "d" = "c";
    "e" = "d";
    "f" = "e";
  };
  # don't ask :)
  base =
    "#"
    + lib.strings.concatStrings (
      (lib.lists.take 5 (lib.strings.stringToCharacters scheme.base00))
      ++ [ hexTable."${(lib.lists.last (lib.strings.stringToCharacters scheme.base00))}" ]
    );
in
{
  options.mods.kitty = {
    enable = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Enables kitty";
    };
    additionalConfig = lib.mkOption {
      default = { };
      example = {
        # for the insane people out there :P
        enable_audio_bell = "yes";
      };
      type = with lib.types; attrsOf anything;
      description = "Additional kitty configuration";
    };
  };
  config = lib.mkIf config.mods.kitty.enable (
    lib.optionalAttrs (options ? home.packages) {
      stylix.targets.kitty = {
        enable = false;
      };
      programs.kitty = {
        enable = true;
        settings = {
          enable_audio_bell = "no";
          window_alert_on_bell = "no";
          cursor_blink_interval = "0";
          window_padding_width = "1";
          shell_integration = "yes";
          sync_with_monitor = "no";
          background_opacity = "0.8";

          font_family = "${config.mods.stylix.fonts.monospace.name}";
          bold_font = "${config.mods.stylix.fonts.monospace.name} Extra Bold";
          italic_font = "${config.mods.stylix.fonts.monospace.name} Extra Italic";
          bold_italic_font = "${config.mods.stylix.fonts.monospace.name} Extra Bold Italic";

          background = base;
          foreground = "#" + scheme.base05;
          selection_foreground = "#" + scheme.base05;
          selection_background = base;
          url_color = "#" + scheme.base04;
          cursor = "#" + scheme.base05;
          active_border_color = "#" + scheme.base03;
          inactive_border_color = "#" + scheme.base01;
          active_tab_background = base;
          active_tab_foreground = "#" + scheme.base05;
          inactive_tab_background = "#" + scheme.base01;
          inactive_tab_foreground = "#" + scheme.base04;
          tab_bar_background = "#" + scheme.base01;

          color0 = base;
          color1 = "#" + scheme.base08;
          color2 = "#" + scheme.base0B;
          color3 = "#" + scheme.base0A;
          color4 = "#" + scheme.base0D;
          color5 = "#" + scheme.base0E;
          color6 = "#" + scheme.base0C;
          color7 = "#" + scheme.base05;

          color8 = "#" + scheme.base03;
          color9 = "#" + scheme.base08;
          color10 = "#" + scheme.base0B;
          color11 = "#" + scheme.base0A;
          color12 = "#" + scheme.base0D;
          color13 = "#" + scheme.base0E;
          color14 = "#" + scheme.base0C;
          color15 = "#" + scheme.base07;

          shell = lib.mkIf config.mods.fish.enable "fish";
        } // config.mods.kitty.additionalConfig;
      };
    }
  );
}
