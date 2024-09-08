{
  lib,
  options,
  config,
  pkgs,
  ...
}:
{
  options.mods.home_packages = {
    useDefaultPackages = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Use default packages (will use additional_packages only if disabled)";
    };
    additional_packages = lib.mkOption {
      default = [ ];
      example = [ pkgs.flatpak ];
      type = with lib.types; listOf package;
      description = ''
        Additional Home manager packages.
        Will be installed regardless of default home manager packages are installed.
      '';
    };
    special_programs = lib.mkOption {
      default = { };
      example = { };
      type = with lib.types; attrsOf anything;
      description = ''
        special program configuration to be added which require programs.something notation.
      '';
    };
    special_services = lib.mkOption {
      default = { };
      example = { };
      type = with lib.types; attrsOf anything;
      description = ''
        special services configuration to be added which require an services.something notation.
      '';
    };
    matrixClient = lib.mkOption {
      default = pkgs.nheko;
      example = null;
      type = with lib.types; nullOr package;
      description = "The matrix client";
    };
    vesktop = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Adds the vesktop discord client";
    };
    ncspot = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
      description = "Adds the ncspot spotify client";
    };
    nextcloudClient = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
      description = "Adds the full desktop nextcloud client (the nextcloud module in dashnix only provides the cli tool)";
    };
    mailClient = lib.mkOption {
      default = pkgs.thunderbird;
      example = null;
      type = with lib.types; nullOr package;
      description = "The email client";
    };
    additionalBrowser = lib.mkOption {
      default = pkgs.brave;
      example = null;
      type = with lib.types; nullOr package;
      description = "Additional browser -> second to firefox, the only installed browser if firefox is disabled";
    };
  };
  config = lib.optionalAttrs (options ? home.packages) {
    home.packages =
      if config.mods.home_packages.useDefaultPackages then
        with pkgs;
        [
          # TODO add fcp once fixed....
          (lib.mkIf config.mods.home_packages.ncspot ncspot)
          (lib.mkIf config.mods.home_packages.vesktop vesktop)
          (lib.mkIf config.mods.home_packages.nextcloudClient nextcloud-client)
          (lib.mkIf (!isNull config.mods.home_packages.matrixClient) config.mods.home_packages.matrixClient)
          (lib.mkIf (!isNull config.mods.home_packages.mailClient) config.mods.home_packages.mailClient)
          (lib.mkIf (
            !isNull config.mods.home_packages.additionalBrowser
          ) config.mods.home_packages.additionalBrowser)
          adw-gtk3
          bat
          brightnessctl
          dbus
          fastfetch
          fd
          ffmpeg
          flake-checker
          gnome-keyring
          gnutar
          greetd.regreet
          killall
          kitty
          libnotify
          lsd
          networkmanager
          nh
          nix-index
          playerctl
          poppler_utils
          pulseaudio
          qt5ct
          qt6ct
          ripgrep
          rm-improved
          system-config-printer
          xournalpp
          zenith
          zoxide
        ]
        ++ config.mods.home_packages.additional_packages
      else
        config.mods.home_packages.additional_packages;

    xdg.configFile."direnv/direnv.toml".source = (pkgs.formats.toml { }).generate "direnv" {
      global = {
        warn_timeout = "-1s";
      };
    };
    programs =
      if config.mods.home_packages.useDefaultPackages then
        config.mods.home_packages.special_programs
      else
        config.mods.home_packages.special_programs;
    services =
      if config.mods.home_packages.useDefaultPackages then
        config.mods.home_packages.special_services
      else
        config.mods.home_packages.special_services;
  };
}
