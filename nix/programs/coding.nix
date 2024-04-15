{ pkgs
, ...
}:
{
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
    neovim
    typst
    neovide
    tree-sitter
    dotnet-runtime_8
    unzip
    pkg-config
    lua-language-server
    nil
    nixpkgs-fmt
    crate2nix
    sqlite
  ];
}
