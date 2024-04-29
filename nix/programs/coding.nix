{ pkgs
, ...
}:
{
  imports = [
    ./nvim/default.nix
  ];

  home.packages = with pkgs; [
    git
    gcc
    meson
    ninja
    rustup
    go
    nodejs_20
    deno
    python3
    typst
    typst-lsp
    typstfmt
    neovide
    tree-sitter
    dotnet-sdk
    unzip
    pkg-config
    sqlite
    plantuml
    vscodium
    gradle
    maven
    jdt-language-server
    adoptopenjdk-jre-bin
    #vscode-extensions.vscjava.vscode-java-test
    #vscode-extensions.vscjava.vscode-java-debug
  ];
}
