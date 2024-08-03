{ lib, config, ... }: {
  # imports = lib.mkIf config.conf.default_base_packages.enable [
  imports = [
    # is wrapped in if statement to enable when needed
    ../programs/gaming/default.nix
    ../programs/themes/stylix.nix
  ];
}
