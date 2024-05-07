{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    openssl
    dbus
    glib
    gtk4
    gtk3
    libadwaita
    gtk-layer-shell
    gtk4-layer-shell
    direnv
    dconf
    gsettings-desktop-schemas
    gnome.nixos-gsettings-overrides
    bibata-cursors
    xorg.xkbutils
    libxkbcommon
    icon-library
    gnome.adwaita-icon-theme
    hicolor-icon-theme
    morewaita-icon-theme
    kdePackages.breeze-icons
    gnome.seahorse
    upower
  ];

  gtk.iconCache.enable = false;

  fonts.packages = with pkgs; [
    cantarell-fonts
  ];

  nix.settings.experimental-features = "nix-command flakes";
  programs.fish.enable = true;
  programs.fish.promptInit = ''
    ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
  '';

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    jdk
    zlib
  ];
  virtualisation.docker.enable = true;

  programs.dconf.enable = true;
  services.upower.enable = true;
  services.printing.enable = true;
  services.dbus.enable = true;
  services.dbus.packages = with pkgs; [
    gnome2.GConf
  ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  # services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
  #   [org.gnome.desktop.interface]
  #   gtk-theme='adw-gtk3'
  #   cursor-theme='Bibata-Modern-Classsic'
  #   cursor-size=24
  # '';

  programs.direnv = {
    package = pkgs.direnv;
    silent = false;
    loadInNixShell = true;
    direnvrcExtra = "";
    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv;
    };
  };
  programs.ssh.startAgent = true;

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "dashie" ];
  virtualisation.virtualbox.guest.enable = true;
}
