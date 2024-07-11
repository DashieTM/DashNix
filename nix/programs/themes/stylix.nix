{ pkgs, config, ... }: {
  stylix = {
    enable = true;
    image = /home/${config.conf.username}/Pictures/backgrounds/shinobu_2k.jpg;
    polarity = "dark";

    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
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

    base16Scheme = config.conf.colorscheme;
  };
}
