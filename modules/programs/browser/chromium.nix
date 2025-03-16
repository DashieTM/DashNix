{
  lib,
  config,
  options,
  pkgs,
  ...
}: {
  options.mods.browser.chromium = {
    enable = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
      description = "Enables chromium";
    };
    # TODO configure chromium
  };
  config = lib.mkIf (config.mods.browser.chromium.enable || config.mods.homePackages.browser == "chromium") (
    lib.optionalAttrs (options ? home.packages) {
      home.packages = with pkgs; [chromium];
    }
  );
}
