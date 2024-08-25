{
  lib,
  options,
  config,
  pkgs,
  ...
}:
{
  options.mods.media_packages = {
    enable = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Default media packages";
    };
    additional_packages = lib.mkOption {
      default = [ ];
      example = [ pkgs.flatpak ];
      type = lib.types.str;
      description = ''
        Additional media packages.
        Will be installed regardless of default media packages are installed.
      '';
    };
  };
  config = (
    lib.optionalAttrs (options ? home.packages) {
      home.packages = config.mods.media_packages.additional_packages;
    }
    // (lib.mkIf config.mods.media_packages.enable (
      lib.optionalAttrs (options ? home.packages) {
        home.packages = with pkgs; [
          # base audio
          pipewire
          wireplumber
          # audio control
          playerctl
          # images
          imv
          # videos
          mpv
          # pdf
          zathura
          evince
          libreoffice-fresh
          onlyoffice-bin
          pdftk
          pdfpc
          polylux2pdfpc
          # spotify
          # video editing
          kdenlive
          # image creation
          inkscape
          gimp
          krita
          yt-dlp
        ];
        programs.obs-studio.enable = true;
        programs.obs-studio.plugins = with pkgs; [ obs-studio-plugins.obs-vaapi ];
      }
    ))
  );
}
