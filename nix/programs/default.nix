{
  imports = [
    ./common.nix
    ./coding.nix
    ./xdg.nix
    ./media.nix
    ./utils.nix
    ./oxi/default.nix
    ./themes/default.nix
    ./individual_configs/default.nix
  ];

  home.username = "dashie";
  home.homeDirectory = "/home/dashie";
  home.stateVersion = "24.05";
}
