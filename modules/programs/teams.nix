{ lib, config, options, pkgs, ... }:
let callPackage = lib.callPackageWith pkgs;
in {
  options.mods.teams = {
    enable = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
      description =
        "Enables teams via a chromium pwa (for the poor souls that have to use this for work)";
    };
  };
  config = lib.mkIf config.mods.teams.enable
    (lib.optionalAttrs (options ? home.packages) {
      home.packages = [ (callPackage ../../override/teams.nix { }) ];
    });
}
