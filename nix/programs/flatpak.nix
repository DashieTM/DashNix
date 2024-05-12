{ lib, ... }: {

  services.flatpak.remotes = lib.mkOptionDefault [{
    name = "flathub-stable";
    location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
  }];
  services.flatpak.uninstallUnmanaged = true;
  services.flatpak.packages = [
    # fallback if necessary, but generally avoided as nix is superior :)
    "com.github.tchx84.Flatseal"
    "io.github.Foldex.AdwSteamGtk"
  ];
}

