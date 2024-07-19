{ pkgs
, ...
}:
{
  home.packages = with pkgs; [
    keepassxc
    nheko
    nextcloud-client
    xournalpp
  ];
}
