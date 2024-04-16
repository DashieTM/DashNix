{ pkgs, ... }:
{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_zen;
  # amd doesn't let you set high performance otherwhise .....
  boot.kernelParams = [
    "amdgpu.ppfeaturemask=0xffffffff"
  ];

  # WARNING: Simply change this for each config
  networking.hostName = "spaceship";

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

  environment.variables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    DIRENV_LOG_FORMAT = "";
  };

  # allows user change later on
  users.mutableUsers=true;
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
    hashedPassword="firstlogin";
  };

  nix.settings = {
    builders-use-substitutes = true;
    # substituters to use
    substituters = [
      "https://anyrun.cachix.org"
    ];

    trusted-public-keys = [
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
    ];
  };

  system.stateVersion = "unstable";
}
