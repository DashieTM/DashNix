{
  lib,
  config,
  options,
  pkgs,
  ...
}:
{
  options.mods.firefox = {
    enable = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Enables firefox";
    };
    configuration = lib.mkOption {
      default = {
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisablePocket = true;
        DisplayBookmarksToolbar = "never";
        DisplayMenuBar = "default-off";
        CaptivePortal = false;
        DisableFirefoxStudies = true;
        DisableTelemetry = true;
        DisableFirefoxAccounts = false;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        OfferToSaveLoginsDefault = false;
        PasswordManagerEnabled = false;
        FirefoxHome = {
          Search = true;
          Pocket = false;
          Snippets = false;
          TopSites = true;
          Highlights = false;
        };
        UserMessaging = {
          ExtensionRecommendations = false;
          SkipOnboarding = true;
        };
      };
      example = { };
      type = with lib.types; attrsOf anything;
      description = "Firefox policy configuration";
    };
    extensions = lib.mkOption {
      default = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        darkreader
        privacy-badger
        vimium
        keepassxc-browser
        i-dont-care-about-cookies
        tokyo-night-v2
      ];
      example = [ ];
      type = with lib.types; listOf package;
      description = "Firefox extensions (from nur)";
    };
  };
  config = lib.mkIf config.mods.firefox.enable (
    lib.optionalAttrs (options ? programs.firefox.profiles) {
      programs.firefox = {
        enable = true;
        policies = config.mods.firefox.configuration;
        profiles.${config.conf.username} = {
          isDefault = true;
          id = 0;
          extensions = config.mods.firefox.extensions;
        };
        profiles."special" = {
          isDefault = false;
          id = 1;
          extensions = config.mods.firefox.extensions;
        };
      };
    }
  );
}
