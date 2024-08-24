{ stdenv, lib, copyDesktopItems, makeDesktopItem, chromium, ... }:
stdenv.mkDerivation (final: {
  pname = "teams-pwa";
  name = final.pname;
  nativeBuildInputs = [ copyDesktopItems ];
  dontUnpack = true;

  desktopItems = [
    (makeDesktopItem {
      name = final.pname;
      icon = final.pname;
      exec = "${chromium}/bin/${
          chromium.meta.mainProgram or chromium.pname
        } --app=https://teams.microsoft.com";
      desktopName = "Microsoft Teams PWA";
      genericName = "Progressive Web App for Microsoft Teams";
      categories = [ "Network" ];
      mimeTypes = [ "x-scheme-handler/msteams" ];
    })
  ];

  meta = with lib; {
    description = "Microsoft Teams PWA";
    homepage = "https://teams.microsoft.com";
    maintainers = with maintainers; [ ners ];
    platforms = chromium.meta.platforms;
  };
})
