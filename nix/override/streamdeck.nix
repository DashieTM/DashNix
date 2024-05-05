{ lib
, pkgs
, python3Packages
, fetchFromGitHub
, writeText
, makeDesktopItem
}:

python3Packages.buildPythonApplication rec {
  pname = "streamdeck-ui";
  version = "4.1.2";

  src = fetchFromGitHub {
    repo = "streamdeck-linux-gui";
    owner = "streamdeck-linux-gui";
    rev = "v${version}";
    sha256 = "sha256-CSsFPGnKVQUCND6YOA9kfO41KS85C57YL9LcrWlQRKo=";
  };

  patches = [
    # nixpkgs has a newer pillow version
    ./streamdeck.patch
  ];

  desktopItems =
    let
      common = {
        name = "streamdeck-ui";
        desktopName = "Stream Deck UI";
        icon = "streamdeck-ui";
        exec = "streamdeck";
        comment = "UI for the Elgato Stream Deck";
        categories = [ "Utility" ];
      };
    in
    builtins.map makeDesktopItem [
      common
      (common // {
        name = "${common.name}-noui";
        exec = "${common.exec} --no-ui";
        noDisplay = true;
      })
    ];

  postInstall =
    let
      udevRules = ''
        SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", TAG+="uaccess"
      '';
    in
    ''
      mkdir -p $out/lib/systemd/user
      substitute scripts/streamdeck.service $out/lib/systemd/user/streamdeck.service \
        --replace '<path to streamdeck>' $out/bin/streamdeck

      mkdir -p "$out/etc/udev/rules.d"
      cp ${writeText "70-streamdeck.rules" udevRules} $out/etc/udev/rules.d/70-streamdeck.rules

      mkdir -p "$out/share/pixmaps"
      cp streamdeck_ui/logo.png $out/share/pixmaps/streamdeck-ui.png
    '';

  dontWrapQtApps = true;
  dontWrapGApps = true;
  makeWrapperArgs = [ "\${qtWrapperArgs[@]}" "\${gappsWrapperArgs[@]}" ];

  format = "pyproject";

  nativeBuildInputs = [
    pkgs.python3Packages.poetry-core
    pkgs.copyDesktopItems
    pkgs.qt6.wrapQtAppsHook
    pkgs.wrapGAppsHook
  ];

  propagatedBuildInputs = with pkgs.python3Packages; [
    importlib-metadata
    setuptools
    filetype
    cairosvg
    pillow
    pynput
    pyside6
    streamdeck
    xlib
  ] ++ lib.optionals stdenv.isLinux [
    pkgs.qt6.qtwayland
  ];

  nativeCheckInputs = [
    pkgs.xvfb-run
    pkgs.python3Packages.pytest
  ];

 # checkPhase = ''
 #   xvfb-run pytest tests
 # '';

  meta = with lib; {
    description = "Linux compatible UI for the Elgato Stream Deck";
    homepage = "https://streamdeck-linux-gui.github.io/streamdeck-linux-gui/";
    license = licenses.mit;
    mainProgram = "streamdeck";
    maintainers = with maintainers; [ majiir ];
  };
}
