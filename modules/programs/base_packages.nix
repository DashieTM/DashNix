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


  config =
    (lib.optionalAttrs (options?environment.systemPackages)
      {
        environment.systemPackages = config.mods.default_base_packages.additional_packages;
      } // (lib.mkIf config.mods.default_base_packages.enable
      (
        lib.optionalAttrs
          (options?environment.systemPackages)
          {
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
              (lib.mkIf config.conf.streamdeck.enable (callPackage
                ../../override/streamdeck.nix
                { }))
            ];

            gtk.iconCache.enable = false;

            fonts.packages = with pkgs; [
              cantarell-fonts
            ];

            virtualisation.docker.enable = true;

            services.upower.enable = true;
            services.dbus.enable = true;
            services.dbus.packages = with pkgs; [
              gnome2.GConf
            ];
            services.avahi = {
              enable = true;
              nssmdns4 = true;
              openFirewall = true;
            };
            programs.starship =
              let
                base16 = pkgs.callPackage inputs.base16.lib { };
                scheme = (base16.mkSchemeAttrs config.stylix.base16Scheme);
                code_format = "[](bg:prev_bg fg:#5256c3)[ $symbol ($version)](bg:#5256c3)";
              in
              {
                enable = true;
                interactiveOnly = true;
                presets = [ "pastel-powerline" ];
                settings =
                  {
                    # derived from https://starship.rs/presets/pastel-powerline
                    format = ''$username$directory$git_branch$git_status$git_metrics[ ](bg:none fg:prev_bg)'';
                    right_format = ''$c$elixir$elm$golang$gradle$haskell$java$julia$nodejs$nim$rust$scala$python$ocaml$opa$perl$zig$dart$dotnet$nix_shell$shell$solidity[](bg:prev_bg fg:#3465A4)$time$os'';
                    username = {
                      show_always = false;
                      style_user = "bg:#5277C3 fg:#${scheme.base05}";
                      style_root = "bg:#5277C3 fg:#${scheme.base05}";
                      format = "[ $user ]($style)[](bg:#3465A4 fg:#5277C3)";
                      disabled = false;
                    };
                    os = {
                      symbols = { NixOS = "  "; };
                      style = "bg:#3465A4 fg:#${scheme.base05}";
                      disabled = false;
                    };
                    directory = {
                      style = "bg:#3465A4 fg:#${scheme.base05}";
                      format = "[ $path ]($style)";
                      truncation_length = 3;
                      truncation_symbol = "…/";
                    };
                    git_branch = {
                      symbol = "";
                      style = "bg:#5256c3 fg:#${scheme.base05}";
                      format = "[ ](bg:#5256c3 fg:prev_bg)[$symbol $branch ]($style)";
                    };
                    git_status = {
                      staged = "+\${count} (fg:#C4A000)";
                      ahead = "⇡\${count} (fg:#C4A000)";
                      diverged = "⇕⇡\${count} (fg:#C4A000)";
                      behind = "⇣\${count} (fg:#C4A000)";
                      stashed = " ";
                      untracked = "?\${count} (fg:#C4A000)";
                      modified = "!\${count} (fg:#C4A000)";
                      deleted = "✘\${count} (fg:#C4A000)";
                      conflicted = "=\${count} (fg:#C4A000)";
                      renamed = "»\${count} (fg:#C4A000)";
                      style = "bg:#5256c3 fg:fg:#C4A000";
                      format = "[$all_status$ahead_behind]($style)";
                    };
                    git_metrics = {
                      disabled = false;
                      format = "([| ](bg:#5256c3)[+$added]($added_style bg:#5256c3)[ -$deleted]($deleted_style bg:#5256c3))";
                    };
                    c = { format = code_format; };
                    elixir = { format = code_format; };
                    elm = { format = code_format; };
                    golang = { format = code_format; };
                    gradle = { format = code_format; };
                    haskell = { format = code_format; };
                    java = { format = code_format; };
                    julia = { format = code_format; };
                    nodejs = { format = code_format; };
                    nim = { format = code_format; };
                    nix_shell = { symbol = ""; format = code_format; };
                    rust = { format = code_format; };
                    scala = { format = code_format; };
                    typst = { format = code_format; };
                    python = { format = code_format; };
                    ocaml = { format = code_format; };
                    opa = { format = code_format; };
                    perl = { format = code_format; };
                    zig = { format = code_format; };
                    dart = { format = code_format; };
                    dotnet = { format = code_format; };
                    # docker_context = {
                    #   symbol = " ";
                    #   style = "bg:#06969A";
                    #   format = "[](bg:#06969A fg:prev_bg)[ $symbol $context ]($style)";
                    # };
                    time = {
                      disabled = false;
                      time_format = "%R"; # Hour:Minute Format
                      style = "bg:#3465A4 fg:#${scheme.base05}";
                      format = "[ $time ]($style)";
                    };
                  };
              };


            programs.fish.enable = true;
            programs.fish.promptInit = ''
              ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
            '';
            programs.nix-ld.enable = true;
            programs.nix-ld.libraries = with pkgs; [
              jdk
              zlib
            ];
            programs.direnv = {
              package = pkgs.direnv;
              silent = false;
              loadInNixShell = true;
              direnvrcExtra = "";
              nix-direnv = {
                enable = true;
                package = pkgs.nix-direnv;
              };
            };
            programs.ssh.startAgent = true;
            programs.gnupg.agent.enable = true;
          })));
}
