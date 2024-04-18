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
  pname = "oxipaste";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "DashieTM";
    repo = "OxiPaste";
    rev = "${version}";
    hash = "sha256-2copt808b4cpmE8HO2H960xLs7OegvOUYYS/6z7fNMk=";
  };

  cargoHash = "sha256-RXaL5y0hohP9VJ7IJCEfdJjyxwY2l555xSwRa9ZiNKc=";

  nativeBuildInputs = with pkgs;[ pkg-config ];

  buildInputs = with pkgs;[
    dbus
    gtk4
    libadwaita
    gtk4-layer-shell
  ];

  meta = with lib; {
    description = "A work in progress notification daemon made with rust and gtk.";
    homepage = "https://github.com/DashieTM/OxiPaste";
    changelog = "https://github.com/DashieTM/OxiPaste/releases/tag/${version}";
    license = licenses.gpl3;
    maintainers = with maintainers; [ DashieTM ];
    mainProgram = "oxipaste";
  };
}
