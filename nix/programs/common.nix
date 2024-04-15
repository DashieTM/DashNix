{ pkgs
, ...
}:
{
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    vesktop
    kitty
    firefox
    fish
    ripgrep
    rm-improved
    bat
    fd
    lsd
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    flatpak
    networkmanager
    zoxide
    pkgs.greetd.greetd
    pkgs.greetd.regreet
    fastfetch
    pkgs.gnome.gnome-keyring
    dbus
    killall
    adw-gtk3
    gradience
    qt5ct
    qt6ct
    libadwaita
    yazi
    gnutar
    fishPlugins.tide
    nix-index
    libnotify
    zenith
  ];

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];

  home.sessionVariables = {
    GOROOT = "$HOME/.go";
  };

  home.keyboard = null;

  programs.nix-index =
    {
      enable = true;
      enableFishIntegration = true;
    };
}
