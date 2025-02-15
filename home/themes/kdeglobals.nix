# This is ABSOLUTE GARGABE, KDE srsly, remove this!
# props to catppuccin mocha for sparing me from doing this manually: https://github.com/catppuccin/kde/blob/main/Resources/Base.colors
{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  base16 = pkgs.callPackage inputs.base16.lib {};

  baseScheme = base16.mkSchemeAttrs config.stylix.base16Scheme;
  power = number: powerIndex:
    if powerIndex == 1
    then number
    else if powerIndex == 0
    then 1
    else number * power number (powerIndex - 1);

  lookupTable = powerIndex: {
    "0" = 0 * (power 16 powerIndex);
    "1" = 1 * (power 16 powerIndex);
    "2" = 2 * (power 16 powerIndex);
    "3" = 3 * (power 16 powerIndex);
    "4" = 4 * (power 16 powerIndex);
    "5" = 5 * (power 16 powerIndex);
    "6" = 6 * (power 16 powerIndex);
    "7" = 7 * (power 16 powerIndex);
    "8" = 8 * (power 16 powerIndex);
    "9" = 9 * (power 16 powerIndex);
    "a" = 10 * (power 16 powerIndex);
    "b" = 11 * (power 16 powerIndex);
    "c" = 12 * (power 16 powerIndex);
    "d" = 13 * (power 16 powerIndex);
    "e" = 14 * (power 16 powerIndex);
    "f" = 15 * (power 16 powerIndex);
  };

  convertHex = hexChars:
    recombineColors [
      (convertColor (lib.lists.take 2 hexChars))
      (convertColor (lib.lists.take 2 (lib.lists.drop 2 hexChars)))
      (convertColor (lib.lists.take 2 (lib.lists.drop 4 hexChars)))
    ];

  convertColor = color: (lookupTable 1).${(lib.lists.head color)} + (lookupTable 0).${(lib.lists.last color)};
  recombineColors = colors: lib.lists.foldr (a: b: (toString a) + "," + (toString b)) "end" colors;

  scheme = {
    base00 = lib.strings.removeSuffix ",end" (
      convertHex (lib.strings.stringToCharacters baseScheme.base00)
    );
    base01 = lib.strings.removeSuffix ",end" (
      convertHex (lib.strings.stringToCharacters baseScheme.base01)
    );
    base02 = lib.strings.removeSuffix ",end" (
      convertHex (lib.strings.stringToCharacters baseScheme.base02)
    );
    base03 = lib.strings.removeSuffix ",end" (
      convertHex (lib.strings.stringToCharacters baseScheme.base03)
    );
    base04 = lib.strings.removeSuffix ",end" (
      convertHex (lib.strings.stringToCharacters baseScheme.base04)
    );
    base05 = lib.strings.removeSuffix ",end" (
      convertHex (lib.strings.stringToCharacters baseScheme.base05)
    );
    base06 = lib.strings.removeSuffix ",end" (
      convertHex (lib.strings.stringToCharacters baseScheme.base06)
    );
    base07 = lib.strings.removeSuffix ",end" (
      convertHex (lib.strings.stringToCharacters baseScheme.base07)
    );
    base08 = lib.strings.removeSuffix ",end" (
      convertHex (lib.strings.stringToCharacters baseScheme.base08)
    );
    base09 = lib.strings.removeSuffix ",end" (
      convertHex (lib.strings.stringToCharacters baseScheme.base09)
    );
    base0A = lib.strings.removeSuffix ",end" (
      convertHex (lib.strings.stringToCharacters baseScheme.base0A)
    );
    base0B = lib.strings.removeSuffix ",end" (
      convertHex (lib.strings.stringToCharacters baseScheme.base0B)
    );
    base0C = lib.strings.removeSuffix ",end" (
      convertHex (lib.strings.stringToCharacters baseScheme.base0C)
    );
    base0D = lib.strings.removeSuffix ",end" (
      convertHex (lib.strings.stringToCharacters baseScheme.base0D)
    );
    base0E = lib.strings.removeSuffix ",end" (
      convertHex (lib.strings.stringToCharacters baseScheme.base0E)
    );
    base0F = lib.strings.removeSuffix ",end" (
      convertHex (lib.strings.stringToCharacters baseScheme.base0F)
    );
  };
in {
  # temp
  # crust -> surface1
  # subtext0 -> surface2
  # accentColor -> lavender
  xdg.configFile."kdeglobals" = {
    text = ''
      [ColorEffects:Disabled]
      Color=${scheme.base01}
      ColorAmount=0.30000000000000004
      ColorEffect=2
      ContrastAmount=0.1
      ContrastEffect=0
      IntensityAmount=-1
      IntensityEffect=0

      [ColorEffects:Inactive]
      ChangeSelectionColor=true
      Color=${scheme.base01}
      ColorAmount=0.5
      ColorEffect=3
      ContrastAmount=0
      ContrastEffect=0
      Enable=true
      IntensityAmount=0
      IntensityEffect=0

      [Colors:Button]
      BackgroundAlternate=${scheme.base07}
      BackgroundNormal=${scheme.base02}
      DecorationFocus=${scheme.base07}
      DecorationHover=${scheme.base02}
      ForegroundActive=${scheme.base09}
      ForegroundInactive=${scheme.base04}
      ForegroundLink=${scheme.base07}
      ForegroundNegative=${scheme.base08}
      ForegroundNeutral=${scheme.base0A}
      ForegroundNormal=${scheme.base05}
      ForegroundPositive=${scheme.base0B}
      ForegroundVisited=${scheme.base0E}


      [Colors:Complementary]
      BackgroundAlternate=${scheme.base03}
      BackgroundNormal=${scheme.base00}
      DecorationFocus=${scheme.base07}
      DecorationHover=${scheme.base02}
      ForegroundActive=${scheme.base09}
      ForegroundInactive=${scheme.base04}
      ForegroundLink=${scheme.base07}
      ForegroundNegative=${scheme.base08}
      ForegroundNeutral=${scheme.base0A}
      ForegroundNormal=${scheme.base05}
      ForegroundPositive=${scheme.base0B}
      ForegroundVisited=${scheme.base0E}


      [Colors:Header]
      BackgroundAlternate=${scheme.base03}
      BackgroundNormal=${scheme.base00}
      DecorationFocus=${scheme.base07}
      DecorationHover=${scheme.base02}
      ForegroundActive=${scheme.base09}
      ForegroundInactive=${scheme.base04}
      ForegroundLink=${scheme.base07}
      ForegroundNegative=${scheme.base08}
      ForegroundNeutral=${scheme.base0A}
      ForegroundNormal=${scheme.base05}
      ForegroundPositive=${scheme.base0B}
      ForegroundVisited=${scheme.base0E}


      [Colors:Selection]
      BackgroundAlternate=${scheme.base07}
      BackgroundNormal=${scheme.base07}
      DecorationFocus=${scheme.base07}
      DecorationHover=${scheme.base02}
      ForegroundLink=${scheme.base07}
      ForegroundInactive=${scheme.base00}
      ForegroundActive=${scheme.base09}
      ForegroundLink=${scheme.base07}
      ForegroundNegative=${scheme.base08}
      ForegroundNeutral=${scheme.base0A}
      ForegroundNormal=${scheme.base03}
      ForegroundPositive=${scheme.base0B}
      ForegroundVisited=${scheme.base0E}


      [Colors:Tooltip]
      BackgroundAlternate=27,25,35
      BackgroundNormal=${scheme.base01}
      DecorationFocus=${scheme.base07}
      DecorationHover=${scheme.base02}
      ForegroundActive=${scheme.base09}
      ForegroundInactive=${scheme.base04}
      ForegroundLink=${scheme.base07}
      ForegroundNegative=${scheme.base08}
      ForegroundNeutral=${scheme.base0A}
      ForegroundNormal=${scheme.base05}
      ForegroundPositive=${scheme.base0B}
      ForegroundVisited=${scheme.base0E}


      [Colors:View]
      BackgroundAlternate=${scheme.base00}
      BackgroundNormal=${scheme.base01}
      DecorationFocus=${scheme.base07}
      DecorationHover=${scheme.base02}
      ForegroundActive=${scheme.base09}
      ForegroundInactive=${scheme.base04}
      ForegroundLink=${scheme.base07}
      ForegroundNegative=${scheme.base08}
      ForegroundNeutral=${scheme.base0A}
      ForegroundNormal=${scheme.base05}
      ForegroundPositive=${scheme.base0B}
      ForegroundVisited=${scheme.base0E}


      [Colors:Window]
      BackgroundAlternate=${scheme.base03}
      BackgroundNormal=${scheme.base00}
      DecorationFocus=${scheme.base07}
      DecorationHover=${scheme.base02}
      ForegroundActive=${scheme.base09}
      ForegroundInactive=${scheme.base04}
      ForegroundLink=${scheme.base07}
      ForegroundNegative=${scheme.base08}
      ForegroundNeutral=${scheme.base0A}
      ForegroundNormal=${scheme.base05}
      ForegroundPositive=${scheme.base0B}
      ForegroundVisited=${scheme.base0E}


      [General]
      ColorScheme=CustomBase16Nix
      Name=CustomBase16Nix
      accentActiveTitlebar=false
      shadeSortColumn=true


      [KDE]
      contrast=4


      [WM]
      activeBackground=${scheme.base01}
      activeBlend=${scheme.base05}
      activeForeground=${scheme.base05}
      inactiveBackground=${scheme.base03}
      inactiveBlend=${scheme.base04}
      inactiveForeground=${scheme.base04}
    '';
  };
}
