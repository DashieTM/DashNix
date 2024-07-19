{
  xdg.configFile."keepassxc/keepassxc.ini" = {
    text =
      ''
        [General]
        ConfigVersion=2

        [Browser]
        CustomProxyLocation=
        Enabled=true

        [GUI]
        ApplicationTheme=classic
        HidePasswords=true
        TrayIconAppearance=monochrome-light

        [PasswordGenerator]
        AdditionalChars=
        ExcludedChars=
        Length=18

        [Security]
        EnableCopyOnDoubleClick=true
      '';
  };
}
