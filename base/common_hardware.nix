{
  pkgs,
  config,
  lib,
  modulesPath,
  ...
}:
let
  username = config.conf.username;
in
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # Bootloader.
  boot = {
    consoleLogLevel = 0;
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };
    plymouth = {
      enable = true;
    };
    kernelPackages = config.conf.kernel;
    initrd = {
      verbose = false;
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
    };
    kernelParams = [
      ''resume="PARTLABEL=SWAP"''
      ''quiet''
      ''udev.log_level=3''
    ] ++ config.conf.boot_params;
  };

  # Enable networking
  networking = {
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
    hostName = config.conf.hostname;
  };

  # Set your time zone.
  time.timeZone = config.conf.timezone;

  # Select internationalisation properties.
  i18n.defaultLocale = config.conf.locale;

  # Enable the X11 windowing system.
  services = {
    flatpak.enable = true;
    xserver.enable = true;
    fstrim.enable = lib.mkDefault true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true;
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault config.conf.system;
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d --delete-generations +5";
    };
    settings = {
      trusted-users = [ username ];
      auto-optimise-store = true;

      experimental-features = "nix-command flakes";
    };
  };

  # Enable sound with pipewire.
  hardware = {
    pulseaudio.enable = false;
    cpu.${config.conf.cpu}.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  security.rtkit.enable = true;

  environment.variables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    DIRENV_LOG_FORMAT = "";
  };

  # allows user change later on
  users = {
    mutableUsers = true;
    users.${username} = {
      isNormalUser = true;
      description = username;
      extraGroups = [
        "networkmanager"
        "wheel"
        "gamemode"
        "docker"
        "vboxusers"
        "video"
        "audio"
      ];
      packages = with pkgs; [
        home-manager
        xdg-desktop-portal-gtk
      ];
      # this password will only last for the first login
      # e.g. login, then change to whatever else, this also ensures no public hash is available
      password = "firstlogin";
    };
  };

}
