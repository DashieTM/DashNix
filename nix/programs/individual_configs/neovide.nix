{ pkgs, ... }: {
  xdg.configFile."neovide/config.toml".source = (pkgs.formats.toml { }).generate "neovide" { };
}
