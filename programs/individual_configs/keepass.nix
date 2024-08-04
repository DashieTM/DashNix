{
  xdg.configFile."keepassxc/keepassxc.ini" = {
    text =
      ''
        [General]
        ConfigVersion=2

        [Browser]
        Enabled=true

        [GUI]
        ApplicationTheme=classic
        HidePasswords=true
        MinimizeOnClose=true
        MinimizeToTray=true
        ShowTrayIcon=true
        TrayIconAppearance=monochrome-light

        [PasswordGenerator]
        Length=30

        [Security]
        EnableCopyOnDoubleClick=true
      '';
  };
}
