{
  lib,
  config,
  options,
  pkgs,
  stable,
  ...
}: let
  name = "firefox";
in {
  imports = [
    (import ./ffextensions.nix
      {inherit lib stable pkgs name;})
  ];
  options.mods.browser.${name} = {
    enable = lib.mkOption {
      default = false;
      example = true;
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
      example = {};
      type = with lib.types; attrsOf anything;
      description = "Firefox policy configuration. See https://mozilla.github.io/policy-templates/ for more information.";
    };
    profiles = lib.mkOption {
      default = [
        {
          name = "${config.conf.username}";
          value = {
            isDefault = true;
            id = 0;
          };
        }
        {
          name = "special";
          value = {
            isDefault = false;
            id = 1;
          };
        }
      ];
      example = [
        {
          name = "custom";
          value = {
            isDefault = true;
            id = 0;
            extensions.packages = [pkgs.nur.repos.rycee.firefox-addons.darkreader];
          };
        }
      ];
      type = with lib.types; listOf (attrsOf anything);
      description = "Firefox profiles";
    };
  };
  config = lib.mkIf (config.mods.browser.firefox.enable || config.mods.homePackages.browser == "firefox") (
    lib.optionalAttrs (options ? programs.firefox.profiles) {
      stylix.targets.firefox.profileNames =
        map (
          {name, ...}:
            name
        )
        config.mods.browser.firefox.profiles;
      programs.firefox = {
        enable = true;
        package =
          pkgs.wrapFirefox
          pkgs.firefox-unwrapped
          {
            pname = "firefox";
            extraPolicies =
              config.mods.browser.firefox.configuration
              // {
                ExtensionSettings = builtins.foldl' (acc: ext: acc // ext) {} config.mods.browser.firefox.extensions;
              };
          };
        profiles = builtins.listToAttrs config.mods.browser.firefox.profiles;
      };
    }
  );
}
