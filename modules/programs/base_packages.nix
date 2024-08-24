{ config, lib, options, pkgs, inputs, ... }: {
  options.mods = {
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
        type = with lib.types; listOf packages;
        description = ''
          Additional packages to install.
          Note that these are installed even if base packages is disabled, e.g. you can also use this as the only packages to install.
        '';
      };
    };
  };

  config = (lib.optionalAttrs (options ? environment.systemPackages) {
    environment.systemPackages =
      config.mods.default_base_packages.additional_packages;
  } // (lib.mkIf config.mods.default_base_packages.enable
    (lib.optionalAttrs (options ? environment.systemPackages) {
      environment.systemPackages = with pkgs; [
        openssl
        dbus
        glib
        gtk4
        gtk3
        libadwaita
        gtk-layer-shell
        gtk4-layer-shell
        direnv
        dconf
        gsettings-desktop-schemas
        gnome.nixos-gsettings-overrides
        bibata-cursors
        xorg.xkbutils
        libxkbcommon
        icon-library
        adwaita-icon-theme
        hicolor-icon-theme
        morewaita-icon-theme
        kdePackages.breeze-icons
        seahorse
        upower
        thunderbird
        podman-tui
        podman-compose
        dive
      ];

      gtk.iconCache.enable = false;

      fonts.packages = with pkgs; [ cantarell-fonts ];

      virtualisation = {
        containers.enable = true;
        podman = {
          enable = true;
          dockerCompat = true;
          defaultNetwork.settings.dns_enabled = true;
        };
      };

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
          libraries = with pkgs; [ jdk zlib ];
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
    })));
}
