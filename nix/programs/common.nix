{ pkgs
, lib
, ...
}:
let callPackage = lib.callPackageWith (pkgs);
in
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
    fastfetch
    pkgs.gnome.gnome-keyring
    dbus
    killall
    adw-gtk3
    qt5ct
    qt6ct
    gnutar
    fishPlugins.tide
    nix-index
    libnotify
    zenith
    nh
    amberol
    pulseaudio
    playerctl
    ncspot
    poppler_utils
    neofetch
    brave
    greetd.regreet
    sops
    (callPackage
      ../override/oxinoti.nix
      { })
    (callPackage
      ../override/oxidash.nix
      { })
    (callPackage
      ../override/oxicalc.nix
      { })
    (callPackage
      ../override/oxipaste.nix
      { })
    (callPackage
      ../override/oxishut.nix
      { })
    (callPackage
      ../override/streamdeck.nix
      { })
    (callPackage
      ../override/reset.nix
      { })
    (callPackage
      ../override/cambalache.nix
      { })
  ];

  home.username = "dashie";
  home.homeDirectory = "/home/dashie";
  home.stateVersion = "24.05";

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];

  home.sessionVariables = {
    GOROOT = "$HOME/.go";
  };

  home.keyboard = null;

  home.file.".local/share/flatpak/overrides/global".text = ''
    [Context]
    filesystems=xdg-config/gtk-3.0;xdg-config/gtk-4.0
  '';

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "adw-gtk3";
      cursor-theme = "Bibata-Modern-Classic";
      cursor-size = 24;
      icon-theme = "MoreWaita";
    };
  };

  programs.nix-index =
    {
      enable = true;
      enableFishIntegration = true;
    };
  home.sessionVariables =
    {
      FLAKE = "home/dasshie/gits/dotFiles/nix";
    };

  sops = {
    gnupg = {
      home = "~/.gnupg";
      sshKeyPaths = [ ];
    };
    defaultSopsFile = ../secrets/secrets.yaml;
    secrets.hub = { };
    secrets.lab = { };
    secrets.dashie = { };
  };
  systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
}
