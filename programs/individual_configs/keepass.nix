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

  home.file.".cache/keepassxc/keepassxc.ini" = {
    text = ''
      [General]
      LastDatabases=/home/dashie/PWs/Passwords.kdbx
      LastActiveDatabase=/home/dashie/PWs/Passwords.kdbx
      LastOpenedDatabases=/home/dashie/PWs/Passwords.kdbx
      LastKeyFiles=@Variant(\0\0\0\x1c\0\0\0\x1\0\0\0>\0/\0h\0o\0m\0\x65\0/\0\x64\0\x61\0s\0h\0i\0\x65\0/\0P\0W\0s\0/\0P\0\x61\0s\0s\0w\0o\0r\0\x64\0s\0.\0k\0\x64\0\x62\0x\0\0\0\n\0\0\0>\0/\0h\0o\0m\0\x65\0/\0\x64\0\x61\0s\0h\0i\0\x65\0/\0P\0W\0s\0/\0l\0o\0g\0i\0n\0_\0k\0\x65\0y\0.\0k\0\x65\0y\0x)
    '';
  };
}
