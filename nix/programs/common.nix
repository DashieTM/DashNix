{ pkgs
, inputs
, lib
, config
, ...
}:
let
  callPackage = lib.callPackageWith (pkgs);
  username = config.conf.username;
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
    fish
    ripgrep
    rm-improved
    bat
    fd
    lsd
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    noto-fonts
    flatpak
    networkmanager
    zoxide
    fastfetch
    pkgs.gnome-keyring
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
    brave
    greetd.regreet
    sops
    flake-checker
    ffmpeg
    system-config-printer
    brightnessctl
    (callPackage
      ../override/cambalache.nix
      { })
  ];

  #my own programs
  programs.oxicalc.enable = true;
  programs.oxinoti.enable = true;
  programs.oxidash.enable = true;
  programs.oxishut.enable = true;
  programs.oxipaste.enable = true;
  programs.hyprdock.enable = true;
  programs.ReSet.enable = true;
  programs.ReSet.config.plugins = [
    inputs.reset-plugins.packages."x86_64-linux".monitor
    inputs.reset-plugins.packages."x86_64-linux".keyboard
  ];
  programs.ReSet.config.plugin_config = {
    Keyboard = {
      path = "/home/${username}/.config/reset/keyboard.conf";
    };
  };

  nixpkgs.config.allowUnfree = true;

  home.username = username;
  home.homeDirectory = "/home/${username}";
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

  sops = {
    gnupg = {
      home = "~/.gnupg";
      sshKeyPaths = [ ];
    };
    defaultSopsFile = ../secrets/secrets.yaml;
    secrets.hub = { };
    secrets.lab = { };
    secrets.${username} = { };
  };
  systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
}
