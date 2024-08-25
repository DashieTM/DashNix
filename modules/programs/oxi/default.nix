{
  lib,
  config,
  options,
  inputs,
  ...
}:
{
  imports = [
    ./oxidash.nix
    ./oxinoti.nix
    ./oxishut.nix
    ./oxipaste.nix
  ];
  options.mods.oxi = {
    enable = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Enables oxi programs";
    };
    ReSet = {
      enable = lib.mkOption {
        default = true;
        example = false;
        type = lib.types.bool;
        description = "Enables and configures ReSet";
      };
    };
    hyprdock = {
      enable = lib.mkOption {
        default = true;
        example = false;
        type = lib.types.bool;
        description = "Enables hyprdock";
      };
    };
    oxicalc = {
      enable = lib.mkOption {
        default = true;
        example = false;
        type = lib.types.bool;
        description = "Enables hyprdock";
      };
    };
  };
  config = lib.mkIf config.mods.oxi.enable (
    lib.optionalAttrs (options ? home.packages) {
      programs = {
        hyprdock.enable = lib.mkIf config.mods.oxi.hyprdock.enable true;
        oxicalc.enable = lib.mkIf config.mods.oxi.oxicalc.enable true;
        ReSet = lib.mkIf config.mods.oxi.ReSet.enable {
          enable = true;
          config = {
            plugins = [
              inputs.reset-plugins.packages."x86_64-linux".monitor
              inputs.reset-plugins.packages."x86_64-linux".keyboard
            ];
            plugin_config = {
              Keyboard = {
                path = "/home/${config.conf.username}/.config/reset/keyboard.conf";
              };
            };
          };
        };
      };
    }
  );
}
