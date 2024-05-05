{ pkgs, ... }:
{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;
  services.flatpak.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.variables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    DIRENV_LOG_FORMAT = "";
  };

  nix.settings.trusted-users = [
    "dashie"
  ];

  # allows user change later on
  users.mutableUsers = true;
  users.users.dashie = {
    isNormalUser = true;
    description = "dashie";
    extraGroups = [ "networkmanager" "wheel" "gamemode" ];
    packages = with pkgs; [
      home-manager
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    # this password will only last for the first login
    # e.g. login, then change to whatever else, this also ensures no public hash is available
    password = "firstlogin";
  };

  system.stateVersion = "unstable";
}
