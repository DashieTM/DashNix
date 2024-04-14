{...}: {
  services.flatpak.remotes = {
    "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
  };
  services.flatpak.packages = [ 
  "flathub:app/com.github.tchx84.Flatseal//stable"
  "flathub:app/dev.vencord.Vesktop//stable"
  "flathub:app/com.rustdesk.RustDesk//stable"
  "flathub:app/io.github.Foldex.AdwSteamGtk//stable"
  "flathub:app/io.github.Foldex.AdwSteamGtk//stable"
  "flathub:app/org.gnome.dspy//stable"
  "flathub:app/org.onlyoffice.desktopeditors//stable"
  "flathub:app/org.gtk.Gtk3theme.adw-gtk3//stable"
  "flathub:app/com.brave.Browser//stable"
  ];
}

