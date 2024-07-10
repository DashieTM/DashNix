{ pkgs
, ...
}:
{
  imports = [
    ./nvim/default.nix
  ];

  home.packages = with pkgs; [
    #basics
    gitui
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
    clang-tools

    #sql
    nodePackages.sql-formatter
    sqls

    #assembly
    asm-lsp

    #yaml
    yamlfmt
    yamllint
    yaml-language-server

    #markdown
    marksman
    mdformat

    #bash
    bash-language-server
    shfmt

    #fsharp
    fsharp
    fsautocomplete

    #haskell
    haskellPackages.cabal-install
    ghc 
    haskellPackages.haskell-language-server

    #html
    html-tidy

    #json
    jq
    nodePackages.vscode-json-languageserver

    #css
    tailwindcss
    tailwindcss-language-server
    vscode-langservers-extracted

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
    tinymist
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
