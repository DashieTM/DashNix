{ pkgs
, stdenv
, lib
, fetchFromGitHub
, rustPlatform
, withALSA ? false
, withClipboard ? true
, withCover ? false
, withPulseAudio ? true
, withPortAudio ? false
, withMPRIS ? true
, withNotify ? true
, withCross ? true
, nix-update-script
, testers
, ncspot
}:

rustPlatform.buildRustPackage rec {
  pname = "ncspot";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "hrkfdn";
    repo = "ncspot";
    rev = "v${version}";
    hash = "sha256-RgA3jV/vD6qgIVQCZ0Sm+9CST4SlqN4MUurVM3nIdh0=";
  };

  cargoHash = "sha256-8ZUgm1O4NmZpxgNRKnh1MNhiFNoBWQHo22kyP3hWJwI=";

  nativeBuildInputs = [ pkgs.pkg-config ]
    ++ lib.optional withClipboard pkgs.python3;

  buildInputs = [ pkgs.ncurses ]
    ++ lib.optional stdenv.isLinux pkgs.openssl
    ++ lib.optional withALSA pkgs.alsa-lib
    ++ lib.optional withClipboard pkgs.xorg.libxcb
    ++ lib.optional withCover pkgs.ueberzug
    ++ lib.optional withPulseAudio pkgs.libpulseaudio
    ++ lib.optional withPortAudio pkgs.portaudio
    ++ lib.optional (withMPRIS || withNotify) pkgs.dbus
    ++ lib.optional stdenv.isDarwin pkgs.Cocoa;

  env.NIX_CFLAGS_COMPILE = lib.optionalString stdenv.isDarwin "-DNCURSES_UNCTRL_H_incl";

  buildNoDefaultFeatures = true;

  buildFeatures = [ "cursive/pancurses-backend" ]
    ++ lib.optional withALSA "alsa_backend"
    ++ lib.optional withClipboard "share_clipboard"
    ++ lib.optional withCover "cover"
    ++ lib.optional withPulseAudio "pulseaudio_backend"
    ++ lib.optional withPortAudio "portaudio_backend"
    ++ lib.optional withMPRIS "mpris"
    ++ lib.optional withCross "crossterm_backend"
    ++ lib.optional withNotify "notify";

  postInstall = ''
    install -D --mode=444 $src/misc/ncspot.desktop $out/share/applications/${pname}.desktop
    install -D --mode=444 $src/images/logo.svg $out/share/icons/hicolor/scalable/apps/${pname}.png
  '';

  passthru = {
    updateScript = nix-update-script { };
    tests.version = testers.testVersion { package = ncspot; };
  };

  meta = with lib; {
    description = "Cross-platform ncurses Spotify client written in Rust, inspired by ncmpc and the likes";
    homepage = "https://github.com/hrkfdn/ncspot";
    changelog = "https://github.com/hrkfdn/ncspot/releases/tag/v${version}";
    license = licenses.bsd2;
    maintainers = with maintainers; [ marsam liff ];
    mainProgram = "ncspot";
  };
}
