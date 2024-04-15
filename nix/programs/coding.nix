{ pkgs
, ...
}:
{
  imports = [
    ../nvim/default.nix
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
    neovide
    tree-sitter
    dotnet-runtime_8
    unzip
    pkg-config
    sqlite
  ];
}
