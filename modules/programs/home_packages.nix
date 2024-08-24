{ lib, options, config, pkgs, inputs, ... }: {
  options.mods.home_packages = {
    enable = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Home manager packages";
    };
    additional_packages = lib.mkOption {
      default = [ ];
      example = [ pkgs.flatpak ];
      type = lib.types.str;
      description = ''
        Additional Home manager packages.
        Will be installed regardless of default home manager packages are installed.
      '';
    };
  };
  config = (lib.optionalAttrs (options ? home.packages) {
    home.packages = config.mods.home_packages.additional_packages;
  } // (lib.mkIf config.mods.home_packages.enable
    (lib.optionalAttrs (options ? home.packages) {
      home.packages = with pkgs; [
        nheko
        nextcloud-client
        xournalpp
        vesktop
        kitty
        fish
        ripgrep
        # TODO add fcp once fixed....
        rm-improved
        bat
        fd
        lsd
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        noto-fonts
        flatpak
        networkmanager
        zoxide
        fastfetch
        gnome-keyring
        dbus
        killall
        adw-gtk3
        qt5ct
        qt6ct
        gnutar
        nix-index
        libnotify
        zenith
        nh
        amberol
        pulseaudio
        playerctl
        ncspot
        poppler_utils
        brave
        greetd.regreet
        flake-checker
        ffmpeg
        system-config-printer
        brightnessctl
      ];

      #my own programs
      programs.oxicalc.enable = true;
      programs.oxinoti.enable = true;
      programs.oxidash.enable = true;
      programs.oxishut.enable = true;
      programs.oxipaste.enable = true;
      programs.hyprdock.enable = true;
      programs.ReSet.enable = true;
      programs.ReSet.config.plugins = [
        inputs.reset-plugins.packages."x86_64-linux".monitor
        inputs.reset-plugins.packages."x86_64-linux".keyboard
      ];
      programs.ReSet.config.plugin_config = {
        Keyboard = {
          path = "/home/${config.conf.username}/.config/reset/keyboard.conf";
        };
      };
    })));
}
