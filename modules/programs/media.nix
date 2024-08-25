{
  lib,
  options,
  config,
  pkgs,
  ...
}:
{
  options.mods.media_packages = {
    useBasePackages = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Default media packages (If disabled, only the additional packages will be installed)";
    };
    additionalPackages = lib.mkOption {
      default = [ ];
      example = [ pkgs.flatpak ];
      type = with lib.types; listOf package;
      description = ''
        Additional media packages.
      '';
    };
  };
  config = (
    lib.optionalAttrs (options ? home.packages) {
      home.packages = config.mods.media_packages.additionalPackages;
    }
    // (lib.mkIf config.mods.media_packages.useBasePackages (
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
