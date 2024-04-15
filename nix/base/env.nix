{ lib
, pkgs
, ...
}: {
  environment.variables = {
    GSETTINGS_SCHEMA_DIR = "${pkgs.glib.getSchemaPath pkgs.gsettings-desktop-schemas}";
    NEOVIDE_MAXIMIZED = "0";
    GPG_TTY = "$(tty)";
    EDITOR = "neovide --no-fork";
    SUDO_EDITOR = "neovide --no-fork";
    SCRIPTS = "$HOME/.config/scripts";
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}