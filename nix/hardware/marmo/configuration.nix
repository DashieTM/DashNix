{
  imports = [
    ../../modules/conf.nix
  ];
  # variables for system
  conf = {
    monitor = "DP-1";
    gaming = {
      enable = true;
      device = 1;
    };
    hostname = "marmo";
  };
}
