{ pkgs, config, lib, modulesPath, ... }:
let username = config.conf.username;
in {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  boot = {
    extraModulePackages =
      [ pkgs.linuxKernel.packages.linux_xanmod_latest.v4l2loopback ];
    kernelModules = [ "v4l2loopback" ];
  };

  # Bootloader.
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 5;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth = { enable = true; };

  # Enable networking
  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;
  networking.hostName = config.conf.hostname;

  services.flatpak.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

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
  hardware.pulseaudio.enable = false;
  hardware.cpu.${config.conf.cpu}.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  services.fstrim.enable = lib.mkDefault true;
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

  boot.kernelPackages = config.conf.kernel;
  boot.initrd.availableKernelModules =
    [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.kernelParams = [ ''resume="PARTLABEL=SWAP"'' ]
    ++ config.conf.boot_params;

  # allows user change later on
  users.mutableUsers = true;
  users.users.${username} = {
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
    packages = with pkgs; [ home-manager xdg-desktop-portal-gtk ];
    # this password will only last for the first login
    # e.g. login, then change to whatever else, this also ensures no public hash is available
    password = "firstlogin";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/ROOT";
    fsType = "btrfs";
    options = [ "noatime" "nodiratime" "discard" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
    options = [ "rw" "fmask=0022" "dmask=0022" "noatime" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/HOME";
    fsType = "btrfs";
    options = [ "noatime" "nodiratime" "discard" ];
  };

  swapDevices = [{ device = "/dev/disk/by-label/SWAP"; }];
}
