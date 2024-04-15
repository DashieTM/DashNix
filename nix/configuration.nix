# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      #./hardware-configuration.nix
      ./base_packages.nix
      ./direnv.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_zen;
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dashie = {
    isNormalUser = true;
    description = "dashie";
    extraGroups = [ "networkmanager" "wheel" "gamemode" ];
    packages = with pkgs; [
      home-manager
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
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

  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;

  system.stateVersion = "unstable"; # Did you read the comment?
}
