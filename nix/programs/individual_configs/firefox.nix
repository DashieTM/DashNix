{ inputs, pkgs, ... }: {
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
    };
    profiles.dashie = {
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
