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
  pname = "oxicalc";
  version = "0.2.4";

  src = fetchFromGitHub {
    owner = "DashieTM";
    repo = "OxiCalc";
    rev = "${version}";
    hash = "sha256-7qrnA0jnLg2mckpxCe66+axU3jE6nOBu7HefmP8I2Xc=";
  };

  cargoHash = "sha256-nxLXT9SVorsgj7qzwX8Ipx8SDvyTYMAcpepTg62QL7o=";

  nativeBuildInputs = with pkgs;[ pkg-config ];

  buildInputs = with pkgs;[
    gtk4
    libadwaita
  ];


  postInstall = ''
    	install -D --mode=444 $src/${pname}.desktop $out/share/applications/${pname}.desktop
    	install -D --mode=444 $src/${pname}.svg $out/share/pixmaps/${pname}.svg
  '';

  meta = with lib; {
    description = "A small, simple calculator written in rust/gtk4";
    homepage = "https://github.com/DashieTM/OxiCalc";
    changelog = "https://github.com/DashieTM/OxiCalc/releases/tag/${version}";
    license = licenses.gpl3;
    maintainers = with maintainers; [ DashieTM ];
    mainProgram = "oxicalc";
  };
}
