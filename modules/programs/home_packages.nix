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
  };
  config =
    (lib.optionalAttrs (options ? home.packages) {
      home.packages = config.mods.home_packages.additional_packages;
    })
    // lib.mkIf config.mods.home_packages.useDefaultPackages (
      lib.optionalAttrs (options ? home.packages) {
        home.packages =
          with pkgs;
          [
            # TODO add fcp once fixed....
            (lib.mkIf config.mods.home_packages.ncspot ncspot)
            (lib.mkIf config.mods.home_packages.vesktop vesktop)
            (lib.mkIf config.mods.home_packages.nextcloudClient nextcloud-client)
            (lib.mkIf (!isNull config.mods.home_packages.matrixClient) config.mods.home_packages.matrixClient)
            (lib.mkIf (!isNull config.mods.home_packages.mailClient) config.mods.home_packages.mailClient)
            adw-gtk3
            bat
            brave
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
          ++ config.mods.home_packages.additional_packages;

        xdg.configFile."direnv/direnv.toml".source = (pkgs.formats.toml { }).generate "direnv" {
          global = {
            warn_timeout = "-1s";
          };
        };

      }
    );
}
