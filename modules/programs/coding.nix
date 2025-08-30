{
  mkDashDefault,
  lib,
  config,
  pkgs,
  options,
  ...
}: let
  font_family = "${config.mods.stylix.fonts.monospace.name}";
in {
  options.mods = {
    coding = {
      enable = lib.mkOption {
        default = true;
        example = false;
        type = lib.types.bool;
        description = ''
          Enables coding packages.
        '';
      };
      dashvim = lib.mkOption {
        default = true;
        example = false;
        type = lib.types.bool;
        description = ''
          Enables dashvim package.
        '';
      };
      jetbrains = lib.mkOption {
        default = false;
        example = true;
        type = lib.types.bool;
        description = ''
          Enables jetbrains toolbox.
        '';
      };
      vscodium = {
        enable = lib.mkOption {
          default = false;
          example = true;
          type = lib.types.bool;
          description = ''
            Enables vscodium.
          '';
        };
        extensions = lib.mkOption {
          default = [];
          example = [];
          type = with lib.types; listOf package;
          description = "Extensions to be installed";
        };
      };
      penpot = lib.mkOption {
        default = false;
        example = true;
        type = lib.types.bool;
        description = "Enables penpot";
      };
      neovide = {
        enable = lib.mkOption {
          default = false;
          example = true;
          type = lib.types.bool;
          description = "Enables neovide";
        };
        config = lib.mkOption {
          default = {
            font = {
              size = 12;
              normal = {
                family = font_family;
                style = "";
              };
              bold = {
                family = font_family;
                style = "ExtraBold";
              };
              italic = {
                family = font_family;
                style = "Italic";
              };
              bold_italic = {
                family = font_family;
                style = "Bold Italic";
              };
            };
          };
          example = {};
          type = with lib.types; attrsOf anything;
          description = "Config for neovide";
        };
      };
      gh = {
        enable = lib.mkOption {
          default = true;
          example = false;
          type = lib.types.bool;
          description = "Enables and configures gh";
        };
        config = lib.mkOption {
          default = {
            version = 1;
            git_protocol = "ssh";
            editor = "";
            prompt = "enabled";
            prefer_editor_prompt = "disabled";
            pager = "";
            aliases = {
              co = "pr checkout";
            };
            http_unix_socket = "";
            browser = "";
          };
          example = {};
          type = with lib.types; attrsOf anything;
          description = "config for gh. Keep in mind, empty values refer to using environment variables";
        };
        hosts = lib.mkOption {
          default = {
            "github.com" = {
              git_protocol = "ssh";
              users = {
                ${config.mods.git.username} = "";
              };
              user = "${config.mods.git.username}";
            };
          };
          example = {};
          type = with lib.types; attrsOf anything;
          description = "hosts for gh";
        };
      };
      useDefaultPackages = lib.mkOption {
        default = true;
        example = false;
        type = lib.types.bool;
        description = "Use default base packages (only additionalPackages are installed if false)";
      };
      additionalPackages = lib.mkOption {
        default = [];
        example = [];
        type = with lib.types; listOf package;
        description = "Additional packages to be installed";
      };
      languages = {
        haskell = {
          enable = lib.mkOption {
            default = true;
            example = false;
            type = lib.types.bool;
            description = ''
              Enables haskell.
            '';
          };
          packages = lib.mkOption {
            default = with pkgs; [
              haskellPackages.cabal-install
              ghc
              haskellPackages.haskell-language-server
            ];
            example = [];
            type = with lib.types; listOf package;
            description = ''
              haskell packages
            '';
          };
        };
        typst = {
          enable = lib.mkOption {
            default = true;
            example = false;
            type = lib.types.bool;
            description = ''
              Enables typst.
            '';
          };
          packages = lib.mkOption {
            default = with pkgs; [
              typst
              tinymist
            ];
            example = [];
            type = with lib.types; listOf package;
            description = ''
              typst packages
            '';
          };
        };
        go = {
          enable = lib.mkOption {
            default = true;
            example = false;
            type = lib.types.bool;
            description = ''
              Enables go.
            '';
          };
          packages = lib.mkOption {
            default = with pkgs; [
              go
              gopls
            ];
            example = [];
            type = with lib.types; listOf package;
            description = ''
              Go packages
            '';
          };
        };
        rust = {
          enable = lib.mkOption {
            default = true;
            example = false;
            type = lib.types.bool;
            description = ''
              Enables rust.
            '';
          };
          packages = lib.mkOption {
            default = with pkgs; [rustup];
            example = [];
            type = with lib.types; listOf package;
            description = ''
              Rust packages
            '';
          };
        };
        ts-js = {
          enable = lib.mkOption {
            default = true;
            example = false;
            type = lib.types.bool;
            description = ''
              Enables TS/JS.
            '';
          };
          packages = lib.mkOption {
            default = with pkgs; [
              nodejs_20
              deno
              typescript
              nodePackages.typescript-language-server
              nodePackages.prettier
            ];
            example = [];
            type = with lib.types; listOf package;
            description = ''
              TS/JS packages
            '';
          };
        };
        zig = {
          enable = lib.mkOption {
            default = true;
            example = false;
            type = lib.types.bool;
            description = ''
              Enables zig.
            '';
          };
          packages = lib.mkOption {
            default = with pkgs; [
              zig
              zls
            ];
            example = [];
            type = with lib.types; listOf package;
            description = ''
              zig packages
            '';
          };
        };
        java = {
          enable = lib.mkOption {
            default = true;
            example = false;
            type = lib.types.bool;
            description = ''
              Enables java.
            '';
          };
          packages = lib.mkOption {
            default = with pkgs; [
              gradle
              maven
              jdt-language-server
              temurin-jre-bin
            ];
            example = [];
            type = with lib.types; listOf package;
            description = ''
              Java packages
            '';
          };
        };
        dotnet = {
          enable = lib.mkOption {
            default = true;
            example = false;
            type = lib.types.bool;
            description = ''
              Enables C#/F#.
            '';
          };
          packages = lib.mkOption {
            default = with pkgs; [
              #.!
              (with dotnetCorePackages;
                combinePackages [
                  sdk_8_0
                  sdk_9_0
                ])
              csharpier
              netcoredbg
              fsharp
              fsautocomplete
            ];
            example = [];
            type = with lib.types; listOf package;
            description = ''
              C#/F# packages
            '';
          };
        };
        C-CPP = {
          enable = lib.mkOption {
            default = true;
            example = false;
            type = lib.types.bool;
            description = ''
              Enables C/C++.
            '';
          };
          packages = lib.mkOption {
            default = with pkgs; [
              bear
              gdb
              gcc
              clang-tools
            ];
            example = [];
            type = with lib.types; listOf package;
            description = ''
              C/C++ packages
            '';
          };
        };
        python = {
          enable = lib.mkOption {
            default = true;
            example = false;
            type = lib.types.bool;
            description = ''
              Enables python.
            '';
          };
          packages = lib.mkOption {
            default = with pkgs; [
              python3
              python312Packages.python-lsp-server
              python312Packages.python-lsp-ruff
              python312Packages.python-lsp-black
            ];
            example = [];
            type = with lib.types; listOf package;
            description = ''
              python packages
            '';
          };
        };
        configFiles = {
          enable = lib.mkOption {
            default = true;
            example = false;
            type = lib.types.bool;
            description = ''
              Enables Json/toml/yaml etc.
            '';
          };
          packages = lib.mkOption {
            default = with pkgs; [
              #yaml
              yamlfmt
              yamllint
              yaml-language-server

              #json
              jq
            ];
            example = [];
            type = with lib.types; listOf package;
            description = ''
              packages for said filetypes
            '';
          };
        };
        bash = {
          enable = lib.mkOption {
            default = true;
            example = false;
            type = lib.types.bool;
            description = ''
              Enables bash.
            '';
          };
          packages = lib.mkOption {
            default = with pkgs; [
              bash-language-server
              shfmt
            ];
            example = [];
            type = with lib.types; listOf package;
            description = ''
              bash packages
            '';
          };
        };
        html-css = {
          enable = lib.mkOption {
            default = true;
            example = false;
            type = lib.types.bool;
            description = ''
              Enables html/css.
            '';
          };
          packages = lib.mkOption {
            default = with pkgs; [
              tailwindcss
              tailwindcss-language-server
              # html-tidy
            ];
            example = [];
            type = with lib.types; listOf package;
            description = ''
              html/css packages
            '';
          };
        };
        sql = {
          enable = lib.mkOption {
            default = true;
            example = false;
            type = lib.types.bool;
            description = ''
              Enables sql.
            '';
          };
          packages = lib.mkOption {
            default = with pkgs; [
              nodePackages.sql-formatter
              sqls
            ];
            example = [];
            type = with lib.types; listOf package;
            description = ''
              sql packages
            '';
          };
        };
        gleam = {
          enable = lib.mkOption {
            default = true;
            example = false;
            type = lib.types.bool;
            description = ''
              Enables gleam.
            '';
          };
          packages = lib.mkOption {
            default = with pkgs; [gleam];
            example = [];
            type = with lib.types; listOf package;
            description = ''
              gleam packages
            '';
          };
        };
        asm = {
          enable = lib.mkOption {
            default = true;
            example = false;
            type = lib.types.bool;
            description = ''
              Enables assembly.
            '';
          };
          packages = lib.mkOption {
            default = with pkgs; [asm-lsp];
            example = [];
            type = with lib.types; listOf package;
            description = ''
              assembly packages
            '';
          };
        };
      };
    };
  };

  config = let
    basePackages = with pkgs; [
      gitui
      meson
      ninja
      tree-sitter
      unzip
      pkg-config
      sqlite
      plantuml
      d-spy
      tmux
      tmate
    ];
  in
    lib.mkIf config.mods.coding.enable (
      lib.optionalAttrs (options ? home.packages) {
        programs.dashvim = lib.mkIf config.mods.coding.dashvim {
          enable = true;
          colorscheme = config.mods.stylix.colorscheme;
        };
        programs.vscode = lib.mkIf config.mods.coding.vscodium.enable {
          enable = true;
          package = mkDashDefault pkgs.vscodium;
          profiles.default.extensions = config.mods.coding.vscodium.extensions;
        };
        xdg.configFile."neovide/config.toml" = lib.mkIf (config.mods.coding.dashvim || config.mods.coding.neovide.enable) {
          source =
            (pkgs.formats.toml {}).generate "neovide"
            config.mods.coding.neovide.config;
        };

        xdg.configFile."gh/config.yml" = lib.mkIf config.mods.coding.gh.enable {
          source =
            (pkgs.formats.yaml {}).generate "config"
            config.mods.coding.gh.config;
        };
        xdg.configFile."gh/hosts.yml" = lib.mkIf config.mods.coding.gh.enable {
          source =
            (pkgs.formats.yaml {}).generate "hosts"
            config.mods.coding.gh.hosts;
        };

        home.packages = with pkgs;
          [
            (lib.mkIf (config.mods.coding.dashvim || config.mods.coding.neovide.enable) neovide)
            (lib.mkIf config.mods.coding.jetbrains jetbrains-toolbox)
            (lib.mkIf config.mods.coding.penpot pkgs.penpot-desktop)
            (lib.mkIf config.mods.coding.gh.enable gh)
          ]
          ++ config.mods.coding.additionalPackages
          ++ (lib.lists.optionals config.mods.coding.useDefaultPackages basePackages)
          ++ (lib.lists.optionals config.mods.coding.languages.haskell.enable config.mods.coding.languages.haskell.packages)
          ++ (lib.lists.optionals config.mods.coding.languages.rust.enable config.mods.coding.languages.rust.packages)
          ++ (lib.lists.optionals config.mods.coding.languages.go.enable config.mods.coding.languages.go.packages)
          ++ (lib.lists.optionals config.mods.coding.languages.java.enable config.mods.coding.languages.java.packages)
          ++ (lib.lists.optionals config.mods.coding.languages.dotnet.enable config.mods.coding.languages.dotnet.packages)
          ++ (lib.lists.optionals config.mods.coding.languages.bash.enable config.mods.coding.languages.bash.packages)
          ++ (lib.lists.optionals config.mods.coding.languages.C-CPP.enable config.mods.coding.languages.C-CPP.packages)
          ++ (lib.lists.optionals config.mods.coding.languages.asm.enable config.mods.coding.languages.asm.packages)
          ++ (lib.lists.optionals config.mods.coding.languages.sql.enable config.mods.coding.languages.sql.packages)
          ++ (lib.lists.optionals config.mods.coding.languages.html-css.enable config.mods.coding.languages.html-css.packages)
          ++ (lib.lists.optionals config.mods.coding.languages.configFiles.enable config.mods.coding.languages.configFiles.packages)
          ++ (lib.lists.optionals config.mods.coding.languages.ts-js.enable config.mods.coding.languages.ts-js.packages)
          ++ (lib.lists.optionals config.mods.coding.languages.typst.enable config.mods.coding.languages.typst.packages)
          ++ (lib.lists.optionals config.mods.coding.languages.zig.enable config.mods.coding.languages.zig.packages)
          ++ (lib.lists.optionals config.mods.coding.languages.gleam.enable config.mods.coding.languages.gleam.packages);
      }
    );
}
