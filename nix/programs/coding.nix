{ lib
, pkgs
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
    # rustpython
    neovim
    typst
    neovide
  ];
}
