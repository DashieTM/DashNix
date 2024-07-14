{ pkgs, config, ... }:
{
  stylix = {
    enable = true;
    image = /home/${config.conf.username}/Pictures/backgrounds/shinobu_2k.jpg;
    polarity = "dark";
    targets = {
      nixvim.enable = false;
      fish.enable = false;
    };

    fonts = {
      serif = {
        package = pkgs.cantarell-fonts;
        name = "Cantarell";
      };

      sansSerif = {
        package = pkgs.cantarell-fonts;
        name = "Cantarell";
      };

      monospace = {
        package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
        # name = "JetBrains Mono Nerd";
        name = "JetBrainsMono Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    base16Scheme =
      (if builtins.isAttrs config.conf.colorscheme then config.conf.colorscheme else "${pkgs.base16-schemes}/share/themes/${config.conf.colorscheme}.yaml");
  };
}
