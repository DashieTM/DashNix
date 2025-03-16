# credits to Voronind for darkreader config https://github.com/voronind-com/nix/blob/main/home/program/firefox/default.nix
{
  lib,
  config,
  options,
  inputs,
  stable,
  system,
  pkgs,
  ...
}: let
  # at time of using this here, stylix might not be evaluated yet
  # hence ensure it is by using base16 mkSchemeAttrs
  base16 = pkgs.callPackage inputs.base16.lib {};
  scheme = base16.mkSchemeAttrs config.stylix.base16Scheme;
  mkExtension = id: install_url: {
    ${id} = {
      inherit install_url;
      installation_mode = "normal_installed";
    };
  };
in {
  options.mods.browser.zen = {
    enable = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
      description = "Enables the zen browser";
    };
    extensions = lib.mkOption {
      default = [
        (mkExtension "uBlock0@raymondhill.net" "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi")
        (mkExtension "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}" "https://addons.mozilla.org/firefox/downloads/latest/user-agent-string-switcher/latest.xpi")
        (mkExtension "{d7742d87-e61d-4b78-b8a1-b469842139fa}" "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi")
        (mkExtension "firefox@ghostery.com" "https://addons.mozilla.org/firefox/downloads/latest/ghostery/latest.xpi")
        (mkExtension "CanvasBlocker@kkapsner.de" "https://addons.mozilla.org/firefox/downloads/latest/canvasblocker/latest.xpi")
        (mkExtension "jid1-KKzOGWgsW3Ao4Q@jetpack" "https://addons.mozilla.org/firefox/downloads/latest/i-dont-care-about-cookies/latest.xpi")
        (mkExtension "keepassxc-browser@keepassxc.org" "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi")
        (mkExtension "@react-devtools" "https://addons.mozilla.org/firefox/downloads/latest/react-devtools/latest.xpi")
        (mkExtension "extension@redux.devtools" "https://addons.mozilla.org/firefox/downloads/latest/reduxdevtools/latest.xpi")
        (mkExtension "private-relay@firefox.com" "https://addons.mozilla.org/firefox/downloads/latest/private-relay/latest.xpi")
        (mkExtension "addon@darkreader.org" "file://${pkgs.callPackage ../../../patches/darkreader.nix {inherit lib stable;}}/latest.xpi")
      ];
      example = [];
      type = with lib.types; listOf anything;
      description = ''
        List of extensions via attrsets:
        ```nix
        # id
        # figure out the id via:
        # nix run github:tupakkatapa/mozid -- 'https://addons.mozilla.org/en/firefox/addon/ublock-origin'
        "uBlock0@raymondhill.net" = {
          # install url
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          # method https://mozilla.github.io/policy-templates/#extensionsettings
          installation_mode = "force_installed";
        };
        ```
      '';
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
        CaptivePortal = false;
        DisableFirefoxStudies = true;
        DisableTelemetry = true;
        NoDefaultBookmarks = true;
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
        "3rdparty".Extensions = {
          "addon@darkreader.org" = {
            theme = {
              darkSchemeBackgroundColor = "#${scheme.base00}";
              darkSchemeTextColor = "#${scheme.base05}";
            };
            previewNewDesign = true;
          };
        };
      };
      example = {};
      type = with lib.types; attrsOf anything;
      description = "Zen policy configuration. See https://mozilla.github.io/policy-templates for more information.";
    };
    profiles = lib.mkOption {
      default = [
        {
          name = "${config.conf.username}";
          value = {
            settings = {
              zen.view.compact.hide-tabbar = false;
              zen.view.compact.hide-toolbar = true;
              zen.view.sidebar-expanded = false;
              zen.view.use-single-toolbar = false;
              zen.view.welcome-screen.seen = true;
              zen.theme.accent-color = "#b4bbff";
              extensions.autoDisableScopes = 0;
            };
            isDefault = true;
            id = 0;
          };
        }
        {
          name = "special";
          value = {
            settings = {
              zen.view.compact.hide-tabbar = false;
              zen.view.compact.hide-toolbar = true;
              zen.view.sidebar-expanded = false;
              zen.view.use-single-toolbar = false;
              zen.view.welcome-screen.seen = true;
              zen.theme.accent-color = "#b4bbff";
              extensions.autoDisableScopes = 0;
            };
            isDefault = false;
            id = 1;
          };
        }
      ];
      example = [
        {
          name = "custom";
          value = {
            settings = {
              extensions.autoDisableScopes = 0;
            };
            extensions.packages = [pkgs.nur.repos.rycee.firefox-addons.darkreader];
            isDefault = true;
            id = 0;
          };
        }
      ];
      type = with lib.types; listOf (attrsOf anything);
      description = "Zen profiles";
    };
  };
  config = lib.mkIf (config.mods.browser.zen.enable || config.mods.homePackages.browser == "firefox") (
    lib.optionalAttrs (options ? home.packages) {
      programs.zen-browser = {
        enable = true;
        package =
          pkgs.wrapFirefox
          inputs.zen-browser.packages.${system}.zen-browser-unwrapped
          {
            pname = "zen-browser";
            extraPolicies =
              config.mods.browser.zen.configuration
              // {
                ExtensionSettings = builtins.foldl' (acc: ext: acc // ext) {} config.mods.browser.zen.extensions;
              };
          };
        profiles = builtins.listToAttrs config.mods.browser.zen.profiles;
      };
    }
  );
}
