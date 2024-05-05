{ pkgs
, ...
}:
{
  home.packages = with pkgs; [
    keepassxc
    nheko
    kdeconnect
    nextcloud-client
    xournalpp
  ];
}
