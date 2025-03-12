{inputs, ...}: let
  mkFirefoxModule = import "${inputs.home-manager.outPath}/modules/programs/firefox/mkFirefoxModule.nix";
in {
  imports = [
    (mkFirefoxModule {
      modulePath = [
        "programs"
        "zen-browser"
      ];
      name = "Zen Browser";
      wrappedPackageName = "zen-browser-unwrapped";
      unwrappedPackageName = "zen-browser";
      visible = true;
      platforms = {
        linux = {
          vendorPath = ".zen";
          configPath = ".zen";
        };
        darwin = {
          configPath = "Library/Application Support/Zen";
        };
      };
    })
  ];
}
