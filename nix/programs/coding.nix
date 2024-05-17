{ pkgs
, ...
}:
{
  imports = [
    ./nvim/default.nix
  ];

  home.packages = with pkgs; [
    #basics
    git
    gcc
    meson
    ninja
    tree-sitter
    unzip
    pkg-config
    sqlite
    plantuml
    d-spy

    # cpp
    bear

    #yaml
    yamlfmt
    yamllint
    yaml-language-server

    #markdown
    marksman

    #html
    html-tidy

    #json
    jsonfmt

    #css
    tailwindcss
    tailwindcss-language-server
    nodePackages_latest.vscode-css-languageserver-bin

    #editors
    neovide
    ##fallback
    vscodium

    #rust
    rustup

    #python
    python3
    python312Packages.python-lsp-server
    python312Packages.python-lsp-ruff
    python312Packages.python-lsp-black

    #ts/js
    nodejs_20
    deno
    typescript
    nodePackages.typescript-language-server
    nodePackages.prettier

    #go
    go
    gopls

    #typst
    typst
    typst-lsp
    typstfmt
    ltex-ls

    #java
    gradle
    maven
    jdt-language-server
    adoptopenjdk-jre-bin

    #.!
    dotnet-sdk_8
    omnisharp-roslyn
    csharpier
    netcoredbg

    #zig
    zig
    zls
  ];
}
