{ pkgs
, lib
, fetchFromGitHub
}:
let
  toolchain = pkgs.rust-bin.selectLatestNightlyWith (toolchain: toolchain.minimal);
  rustPlatform = pkgs.makeRustPlatform {
    cargo = toolchain;
    rustc = toolchain;
  };
in
rustPlatform.buildRustPackage rec {
  pname = "oxishut";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "DashieTM";
    repo = "OxiShut";
    rev = "${version}";
    hash = "sha256-aCNnNxmIHq+IjjviWNGSHfdXT55s367GTAeQoaTZ/KA=";
  };

  cargoHash = "sha256-UeoBSHwMGfhkgRT7kmelcG3/omtB03Wh4IZrTy3yf3Y=";

  nativeBuildInputs = with pkgs;[ pkg-config glib ];

  buildInputs = with pkgs;[
    gtk4
    libadwaita
    gtk4-layer-shell
  ];

  meta = with lib; {
    description = "";
    homepage = "https://github.com/DashieTM/OxiShut";
    changelog = "https://github.com/DashieTM/OxiShut/releases/tag/${version}";
    license = licenses.gpl3;
    maintainers = with maintainers; [ DashieTM ];
    mainProgram = "oxishut";
  };
}
