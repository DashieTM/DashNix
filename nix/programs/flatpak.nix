{ lib, ... }: {

  services.flatpak.remotes = lib.mkOptionDefault [{
    name = "flathub-stable";
    location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
  }];
  services.flatpak.uninstallUnmanaged = true;
  services.flatpak.packages = [
    "com.github.tchx84.Flatseal"
    "io.github.Foldex.AdwSteamGtk"
    "org.gnome.dspy"
    "org.onlyoffice.desktopeditors"
    "org.gtk.Gtk3theme.adw-gtk3"
    "com.brave.Browser"
  ];
}

