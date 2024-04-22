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
  pname = "oxidash";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "DashieTM";
    repo = "OxiDash";
    rev = "${version}";
    hash = "sha256-GVkmqwn3mHriMHUfEej4LW0MaYURqtsftC5L+Cox+5E=";
  };

  cargoHash = "sha256-seFHiBht0vc+iqQw5bd22qVvdhCMqDthWuth3NTm8OY=";

  nativeBuildInputs = with pkgs;[
    pkg-config
    glib
    wrapGAppsHook4
  ];

  buildInputs = with pkgs;[
    dbus
    gtk4
    gtk4-layer-shell
    libadwaita
  ];

  meta = with lib; {
    description = "A work in progress notification daemon made with rust and gtk.";
    homepage = "https://github.com/DashieTM/OxiDash";
    changelog = "https://github.com/DashieTM/OxiDash/releases/tag/${version}";
    license = licenses.gpl3;
    maintainers = with maintainers; [ DashieTM ];
    mainProgram = "oxidash";
  };
}
