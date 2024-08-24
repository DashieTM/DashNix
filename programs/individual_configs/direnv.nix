{ pkgs, ... }: {
  xdg.configFile."direnv/direnv.toml".source =
    (pkgs.formats.toml { }).generate "direnv" {
      global = { warn_timeout = "-1s"; };
    };
}
