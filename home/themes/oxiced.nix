{
  config,
  inputs,
  pkgs,
  ...
}: let
  # at time of using this here, stylix might not be evaluated yet
  # hence ensure it is by using base16 mkSchemeAttrs
  base16 = pkgs.callPackage inputs.base16.lib {};
  scheme = base16.mkSchemeAttrs config.stylix.base16Scheme;
  valueOrDefault = value: fallback:
    if (scheme ? oxiced && scheme.oxiced ? ${value})
    then scheme.oxiced.value
    else fallback;
in {
  xdg.configFile."oxiced/theme.toml" = {
    source = (pkgs.formats.toml {}).generate "oxiced" {
      base = valueOrDefault "base" scheme.base00;
      mantle = valueOrDefault "mantle" scheme.base01;
      primary_bg = valueOrDefault "primary_bg" scheme.base02;
      secondary_bg = valueOrDefault "secondary_bg" scheme.base03;
      tertiary_bg = valueOrDefault "tertiary_bg" scheme.base04;
      text = valueOrDefault "text" scheme.base05;

      primary = valueOrDefault "primary" scheme.base0D;
      primary_contrast = valueOrDefault "primary_contrast" "FFFFFF";
      secondary = valueOrDefault "primary" scheme.base07;
      secondary_contrast = valueOrDefault "secondary_contrast" "FFFFFF";

      good = valueOrDefault "good" scheme.base0B;
      good_contrast = valueOrDefault "good_contrast" "000000";
      bad = valueOrDefault "bad" scheme.base08;
      bad_contrast = valueOrDefault "bad_contrast" "FFFFFF";
      warning = valueOrDefault "warning" scheme.base0A;
      warning_contrast = valueOrDefault "warning_contrast" "000000";
      info = valueOrDefault "info" scheme.base0C;
      info_contrast = valueOrDefault "info_contrast" "FFFFFF";

      rose = valueOrDefault "rose" scheme.base06;
      lavender = valueOrDefault "lavender" scheme.base07;
      blue = valueOrDefault "blue" scheme.base0D;
      mauve = valueOrDefault "mauve" scheme.base0E;
      flamingo = valueOrDefault "flamingo" scheme.base0F;

      border_color_weak = valueOrDefault "border_color_weak" scheme.base05;
      border_color_strong = valueOrDefault "border_color_strong" scheme.base0D;

      tint_amount = valueOrDefault "tint_amound" 0.10;
      shade_amount = valueOrDefault "shade_amount" 0.05;

      border_radius = valueOrDefault "border_radius" 10;

      padding_xs = valueOrDefault "padding_xs" 4.0;
      padding_sm = valueOrDefault "padding_sm" 8.0;
      padding_md = valueOrDefault "padding_md" 12.0;
      padding_lg = valueOrDefault "padding_lg" 16.0;
      padding_xl = valueOrDefault "padding_xl" 24.0;
      padding_xxl = valueOrDefault "padding_xxl" 32.0;

      font_sm = valueOrDefault "font_sm" 10.0;
      font_md = valueOrDefault "font_md" 14.0;
      font_lg = valueOrDefault "font_lg" 18.0;
      font_xl = valueOrDefault "font_xl" 24.0;
      font_xxl = valueOrDefault "font_xxl" 32.0;

      # legacy compatibility
      name = scheme.scheme;
      base00 = scheme.base00;
      base01 = scheme.base01;
      base02 = scheme.base02;
      base03 = scheme.base03;
      base04 = scheme.base04;
      base05 = scheme.base05;
      base06 = scheme.base06;
      base07 = scheme.base07;
      base08 = scheme.base08;
      base09 = scheme.base09;
      base0a = scheme.base0A;
      base0b = scheme.base0B;
      base0c = scheme.base0C;
      base0d = scheme.base0D;
      base0e = scheme.base0E;
      base0f = scheme.base0F;
    };
  };
}
