{ pkgs
, ...
}:
let
  customKeyboardLayout = pkgs.writeText "us_int" ''
    xkb_symbols "us_int"
    {
      include "us(basic)"
      key <AC11> {[ apostrophe, dead_diaeresis, apostrophe, quotedouble ] };
      key <TLDE> {[ grave,      asciitilde                              ] };
    };
  '';
  compiledLayout = pkgs.runCommand "keyboard-layout" { } ''
    ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${customKeyboardLayout} $out
  '';
in
{
  environment.systemPackages = [ pkgs.xorg.xkbcomp ];
  services.xserver.xkb.extraLayouts.us_int = {
    description = "US layout with 'umlaut'";
    languages = [ "eng" ];
    #symbolsFile = ${customKeyboardLayout};
    symbolsFile = /home/dashie/.config/symbols/us_int;
  };
  #services.xserver.displayManager.sessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${compiledLayout} $DISPLAY";
}

