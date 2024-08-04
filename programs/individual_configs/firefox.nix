{ pkgs, config, ... }: {
  programs.firefox = {
    enable = true;

    policies = {
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
    profiles.${config.conf.username} = {
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        darkreader
        privacy-badger
        vimium
        keepassxc-browser
        i-dont-care-about-cookies
        tokyo-night-v2
      ];
    };
  };
}
