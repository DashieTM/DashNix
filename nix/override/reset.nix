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
  pname = "reset";
  version = "1.1.1";

  src = fetchFromGitHub {
    owner = "Xetibo";
    repo = "ReSet";
    rev = "${version}";
    hash = "sha256-nyEGhD4IlsJ1AqRZC7aP2vOuq4etvZ7BwTMxb4u7cxY=";
  };

  cargoHash = "sha256-lcNu8yEQiSTshXCwblBLYpSJWmErS53z+SviqaqlSnI=";

  nativeBuildInputs = with pkgs;[
    pkg-config
    glib
    wrapGAppsHook4
  ];

  buildInputs = with pkgs;[
    gtk4
    libadwaita
    pulseaudio
    dbus
    gdk-pixbuf
    gnome.adwaita-icon-theme
  ];

  postInstall = ''
    	install -D --mode=444 $src/${pname}.desktop $out/share/applications/${pname}.desktop
    	install -D --mode=444 $src/src/resources/icons/ReSet.svg $out/share/pixmaps/ReSet.svg
  '';

  meta = with lib; {
    description = "";
    homepage = "https://github.com/Xetibo/ReSet";
    changelog = "https://github.com/Xetibo/ReSet/releases/tag/${version}";
    license = licenses.gpl3;
    maintainers = with maintainers; [ DashieTM ];
    mainProgram = "reset";
  };
}
