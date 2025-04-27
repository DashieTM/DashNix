
<div align = center>

![Logo of DashNix](logo.svg)

</div>

An opinionated flake to bootstrap NixOS systems with default configurations for various programs and services from both NixOS and HomeManger which can be enabled, disabled, configured or replaced at will.


# Usage

This flake is intended to be used as an input to your own NixOS configuration:

```nix
dashNix = {
  url = "github:Xetibo/DashNix";
  inputs = {
    # ensure these are here to update the packages on your own
    nixpkgs.follows = "nixpkgs";
    stable.follows = "stable";
  };
};
```

You can then configure your systems in your flake outputs with a provided library command:

```nix
nixosConfigurations = inputs.dashNix.dashNixLib.build_systems { root = ./.; };
```

This command will build each system that is placed within the hosts/ directory.
In this directory create one directory for each system you want to configure with DashNix.
This will automatically pick up the hostname for the system and look for 3 different files that are explained below.
(Optionally, you can also change the parameter root (./.) to define a different starting directory than hosts/)

In order for your configuration to work, you are required to at least provide a single config file with a further config file being optional for custom configuration.
The hardware.nix specifies additional NixOS configuration, while home.nix specifies additional home-manager configuration. (both optional)

|- flake.nix\
|- flake.lock\
|- hosts/\
|--- system1/\
|------ configuration.nix (required)\
|------ hardware.nix (optional)\
|------ home.nix (optional)\
|--- system2/\
|------ configuration.nix (required)\
|------ hardware.nix (optional)\
|------ home.nix (optional)\
|--- system3/\
|------ configuration.nix (required)\
|------ hardware.nix (optional)\
|------ home.nix (optional)

Here is a minimal required configuration.nix (the TODOs mention a required change):

```nix
{config, ...}: {
  # variables for system
  # TODO important changes
  conf = {
    # change this to your monitor and your pc name
    # should be something like DP-1
    defaultMonitor = "YOURMONITOR";
    # width x height  @ refreshrate
    defaultMonitorMode = "1920x1080@60";
    # scale for your main monitor
    defaultMonitorScale = "1";
    # your username
    username = "YOURNAME";
    # TODO only needed when you use intel -> amd is default
    # cpu = "intel";
    locale = "something.UTF-8";
    timezone = "CONTINENT/CITY";
  };
  # modules
  mods = {
    # default disk config has root home boot and swap partition, overwrite if you want something different
    drives = {
        # default assumes ROOT, BOOT, HOME and SWAP labaled drives exist
        # for an example without HOME see below
        # defaultDrives.enable = false;
        # extraDrives = [
        #   {
        #     name = "boot";
        #     drive = {
        #       device = "/dev/disk/by-label/BOOT";
        #       fsType = "vfat";
        #       options = [ "rw" "fmask=0022" "dmask=0022" "noatime" ];
        #     };
        #   }
        #   {
        #     name = "";
        #     drive = {
        #       device = "/dev/disk/by-label/ROOT";
        #       fsType = "ext4";
        #       options = [ "noatime" "nodiratime" "discard" ];
        #     };
        #   }
        # ];
        # You can also use disko to format your disks on installation. 
        # Please refer to the Documentation about the drives module for an example.
    };
    sops.enable = false;
    nextcloud.enable = false;
    # default hyprland monitor config -> uncomment when necessary
    # TODO: Add more monitors when needed
    #   hyprland.monitor = [
    #     # default
    #     "${config.conf.defaultMonitor},${config.conf.defaultMonitorMode},0x0,${config.conf.defaultMonitorScale}"
    #     # second example monitor
    #     "DP-2,3440x1440@180,auto,1"
    #     # all others
    #     ",highrr,auto,1"
    #   ];
    # or amd, whatever you have
    gpu.nvidia.enable = true;
    kde_connect.enable = true;
    # login manager:
    # default is greetd
    # greetd = { };
    # sddm = { };
    # gdm = { };
  };
}
```

## First Login

After logging in the first time, your password will be set to "firstlogin", please change this to whatever you like.

## Nixos and Home-manager Modules

You can add additional modules or remove all of them by overriding parameters to the build_systems command:

```nix
nixosConfigurations =
    let
        additionalMods = {
            nixos = [
            # your modules
            ]; home = [
            # your modules
            ];
        }
        # passing this parameter will override the existing modules
        mods = {
            nixos = [];
            home = [];
        }
    in
    inputs.dashNix.dashNixLib.build_systems { root = ./.; inherit mods additionalMods; };
```

## Additional Inputs

Just like modules, you can add additional inputs to your configuration.

```nix
nixosConfigurations =
    let
        additionalInputs = {
            something.url = "yoururl"
        }
    in
    inputs.dashNix.dashNixLib.build_systems { root = ./.; inherit additionalInputs; };
```

## Stable/Unstable

Sometimes you want to differentiate between systems that are stable and unstable, e.g. for servers and desktops/laptops.
This can be done with the overridePkgs flag for the lib function:

```nix
 nixosConfigurations =
   inputs.dashNix.dashNixLib.build_systems {
     root = ./stable;
     inherit additionalInputs;
     overridePkgs = true;
   }
   // inputs.dashNix.dashNixLib.build_systems {
     root = ./unstable;
     inherit additionalInputs;
   };
```

You can now place your systems in the respective directories.
Keep in mind that the hosts directory will still need to exist in each variant. 
E.g. stable/hosts/yourserver and unstable/hosts/yourdesktop

# Installation

You can find a custom ISO on my NextCloud server: [Link](https://cloud.dashie.org/s/z7G3zS9SXeEt2ERD).
With this, you will receive the example config in /iso/example alongside the gnome desktop environment,
as well as a few tools like gnome-disks, neovim, vscodium, a browser etc.

Alternatively, you can use whatever NixOS installer and just install your config from there, just make sure to set the drive configuration before.

## Commands

First, copy the readonly config from /iso/example-config to a location of your choice.

```sh
cp /iso/example-config ~/config -r
```

Then configure as you please and choose a command below depending on your disk installation variant.

Installation via manual configuration:

```sh
sudo nixos-install --flake <flakelocation>#<hostname> --root <mountpoint>
#example
#nixos-install --flake ~/config#globi --root /mnt 
```

Installation via disko:

```sh
sudo disko-install --flake <flakelocation>#<hostname> --disk <disk-name> <disk-device>
#example
#disko-install -- --flake ~/config#globi --disk main /dev/nvme0n1
```

# Modules

This configuration features several modules that can be used as preconfigured "recipies".
These modules attempt to combine the home-manager and nixos packages/options to one single configuration file for each new system.
For package lists, please check the individual modules, as the lists can be long.

- Hyprland: Installs and configures Hyprland with various additional packages
- acpid : Enables the acpid daemon
- base packages : A list of system packages to be installed by default
- bluetooth : Configures/enables bluetooth and installs tools for bluetooth
- coding packages : A list of coding packages to be installed by default
- drives : A drive configuration module
- firefox: Enables and configures firefox (extensions and settings)
- fish: Enables and configures fish shell
- flatpak : Installs and enables declarative flatpak
- gaming : Configures gaming related features (launchers, gamemode)
- git : Git key and config module
- gnome_services : Gnome services for minimal enviroments -> Window managers etc
- gpu : GPU settings (AMD)
- greetd : Enables and configures the greetd/regreet login manager with Hyprland
- home packages : A list of home packages to be installed by default
- kde_connect : Enables KDE connect and opens its ports
- keepassxc : Configures keepassxc
- kitty: Enables and configures kitty terminal
- layout : Modules to configure keyboard layout system wide
- media packages : A list of media packages to be installed by default
- mime: Mime type configuration
- nextcloud : Handles synchronization via nextcloud cmd. (requires config.sops.secrets.nextcloud)
- oxi: My own programs, can be selectively disabled, or as a whole
- piper : Installs and enables piper alongside its daemon
- plymouth: enable or disable plymouth
- printing : Enables and configures printing services
- scripts: Various preconfigured scripts with the ability to add more
- sops: Enables sops-nix
- starship : Configures the starship prompt
- stylix : Configures system themes, can also be applied to dashvim if used.
- teams: For the poor souls that have to use this....
- virtualbox : Enables and configures virtualbox
- xkb: Keyboard layout configuration
- xone : Installs the xone driver
- yazi: Installs yazi and sets custom keybinds

# Credits

- [Fufexan](https://github.com/fufexan) for the xdg-mime config:
- [Catppuccin](https://github.com/catppuccin) for base16 colors and zen-browser css
- [Danth](https://github.com/danth) for providing a base for the nix docs
- [chermnyx](https://github.com/chermnyx) for providing a base for zen configuration
- [voronind-com](https://github.com/voronind-com) for providing the darkreader configuration
- [Nix-Artwork](https://github.com/NixOS/nixos-artwork/tree/master/logo) for the Nix/NixOS logo (Tim Cuthbertson (@timbertson))
