{
  config,
  lib,
  options,
  pkgs,
  inputs,
  ...
}:
{
  options.mods = {
    base_packages = {
      default_base_packages = {
        enable = lib.mkOption {
          default = true;
          example = false;
          type = lib.types.bool;
          description = ''
            Enables default system packages.
          '';
        };
        additional_packages = lib.mkOption {
          default = [ ];
          example = [ pkgs.openssl ];
          type = with lib.types; listOf package;
          description = ''
            Additional packages to install.
            Note that these are installed even if base packages is disabled, e.g. you can also use this as the only packages to install.
          '';
        };
      };
    };
  };

  config = (
    lib.optionalAttrs (options ? environment.systemPackages) {
      environment.systemPackages = config.mods.base_packages.default_base_packages.additional_packages;
    }
    // (lib.mkIf config.mods.base_packages.default_base_packages.enable (
      lib.optionalAttrs (options ? environment.systemPackages) {
        environment.systemPackages = with pkgs; [
          adwaita-icon-theme
          dbus
          dconf
          direnv
          glib
          gnome.nixos-gsettings-overrides
          gsettings-desktop-schemas
          gtk-layer-shell
          gtk3
          gtk4
          gtk4-layer-shell
          hicolor-icon-theme
          icon-library
          kdePackages.breeze-icons
          libadwaita
          libxkbcommon
          nixfmt-rfc-style
          openssl
          seahorse
          upower
          xorg.xkbutils
        ];

        gtk.iconCache.enable = false;
        services = {
          upower.enable = true;
          dbus = {
            enable = true;
            packages = with pkgs; [ gnome2.GConf ];
          };
          avahi = {
            enable = true;
            nssmdns4 = true;
            openFirewall = true;
          };
        };

        programs = {
          nix-ld = {
            enable = true;
            libraries = with pkgs; [
              jdk
              zlib
            ];
          };
          direnv = {
            package = pkgs.direnv;
            silent = false;
            loadInNixShell = true;
            direnvrcExtra = "";
            nix-direnv = {
              enable = true;
              package = pkgs.nix-direnv;
            };
          };
          ssh.startAgent = true;
          gnupg.agent.enable = true;
        };
      }
    ))
  );
}
