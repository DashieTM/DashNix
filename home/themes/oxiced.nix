{
  config,
  inputs,
  pkgs,
  ...
}:
let
  # at time of using this here, stylix might not be evaluated yet
  # hence ensure it is by using base16 mkSchemeAttrs
  base16 = pkgs.callPackage inputs.base16.lib { };
  scheme = (base16.mkSchemeAttrs config.stylix.base16Scheme);
in
{
  xdg.configFile."oxiced/theme.toml" = {
    source = (pkgs.formats.toml { }).generate "oxiced" {
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
