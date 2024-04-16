{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    openssl
    dbus
    glib
    gtk4
    gtk3
    gtk-layer-shell
    gtk4-layer-shell
    direnv
    dconf
    gsettings-desktop-schemas
    gnome.nixos-gsettings-overrides
    gnome.adwaita-icon-theme
    bibata-cursors
    xorg.xkbutils
  ];

  fonts.packages = with pkgs; [
    cantarell-fonts
  ];

  environment.variables = {
    NIX_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (config.systemd.packages ++ config.environment.systemPackages);
    PKG_CONFIG_PATH = pkgs.lib.makeLibraryPath (config.systemd.packages ++ config.environment.systemPackages);
  };
  nix.settings.experimental-features = "nix-command flakes";
  programs.fish.enable = true;
  programs.fish.promptInit = ''
    ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
  '';

  programs.dconf.enable = true;
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
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.desktop.interface]
    gtk-theme='adw-gtk3'
    cursor-theme='Bibata-Modern-Classsic'
    cursor-size=24
  '';

}
