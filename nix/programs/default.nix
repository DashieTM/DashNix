{
  imports = [
    ./common.nix
    ./kitty.nix
    ./coding.nix
    ./xdg.nix
    ./media.nix
    ./utils.nix
    ./yazi.nix
    ./oxi/default.nix
    #./gtk.nix
    #./cargo.nix
  ];

  home.username = "dashie";
  home.homeDirectory = "/home/dashie";
  home.stateVersion = "24.05";
}
