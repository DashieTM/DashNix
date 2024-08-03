```
  _____            _     _____        _
 |  __ \          | |   |  __ \      | |
 | |  | | __ _ ___| |__ | |  | | ___ | |_ ___
 | |  | |/ _` / __| '_ \| |  | |/ _ \| __/ __|
 | |__| | (_| \__ \ | | | |__| | (_) | |_\__ \
 |_____/ \__,_|___/_| |_|_____/ \___/ \__|___/

```

My personal configuration for NixOS/home-manager.
While not intended to be used by someone else, feel free to do so anyway or use it as a template for your configuration if you wish to.

# Modules

This configuration features several modules that can be used as preconfigured "recipies".
These modules attempt to combine the home-manager and nixos packages/options to one single configuration file for each new system.
For package lists, please check the individual modules, as the lists can be long.

- base packages : A list of system packages to be installed by default
- home packages : A list of home packages to be installed by default
- media packages : A list of media packages to be installed by default
- coding packages : A list of coding packages to be installed by default
- acpid : Enables the acpid daemon
- bluetooth : Configures/enables bluetooth and installs tools for bluetooth
- drives : A drive configuration module
- flatpak : Installs and enables declarative flatpak
- gnome_services : Gnome services for minimal enviroments -> Window managers etc
- gpu : GPU settings (AMD)
- greetd : Enables and configures the greetd/regreet login manager with Hyprland
- kde_connect : Enables KDE connect and opens its ports
- layout : Modules to configure keyboard layout system wide
- piper : Installs and enables piper alongside its daemon
- printing : Enables and configures printing services
- virtualbox : Enables and configures virtualbox
- xone : Installs the xone driver
- Hyprland: Installs and configures Hyprland with various additional packages
