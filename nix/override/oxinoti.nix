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
  pname = "oxinoti";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "DashieTM";
    repo = "OxiNoti";
    rev = "${version}";
    hash = "sha256-XZMfJ2kUTd8+XiDgZFbG1sOPt37e4M+1rgp4Bdlej7s=";
  };

  cargoHash = "sha256-jIdev6K5MQ8jASDo1KWU89rSLd9UhI2MhTT4l7pP+tA=";

  nativeBuildInputs = with pkgs;[ pkg-config ];

  buildInputs = with pkgs;[
    dbus
    gtk3
    gtk-layer-shell
  ];

  #postInstall = ''
  #  install -D --mode=444 $src/misc/ncspot.desktop $out/share/applications/${pname}.desktop
  #  install -D --mode=444 $src/images/logo.svg $out/share/icons/hicolor/scalable/apps/${pname}.png
  #'';

  #passthru = {
  #  updateScript = nix-update-script { };
  #  tests.version = testers.testVersion { package = oxinoti; };
  #};

  meta = with lib; {
    description = "A work in progress notification daemon made with rust and gtk.";
    homepage = "https://github.com/DashieTM/OxiNoti";
    changelog = "https://github.com/DashieTM/OxiNoti/releases/tag/${version}";
    license = licenses.gpl3;
    maintainers = with maintainers; [ DashieTM ];
    mainProgram = "oxinoti";
  };
}
