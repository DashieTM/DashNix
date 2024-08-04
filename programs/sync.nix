{ config, pkgs, options, lib, ... }:
let
  username = config.mods.nextcloud.username;
  password = config.sops.secrets.nextcloud.path;
  url = config.mods.nextcloud.url;
  synclist = config.mods.nextcloud.synclist;
in
lib.mkIf config.mods.nextcloud.enable {
  systemd.user = {
    services =
      (builtins.listToAttrs
        (map
          (opts: {
            name = "${opts.name}";
            value = {
              Unit = {
                Description = "Auto sync Nextcloud";
                After = "network-online.target";
              };
              Service = {
                Type = "simple";
                ExecStart = "${pkgs.nextcloud-client}/bin/nextcloudcmd -h --path ${opts.remote} ${opts.local} https://${username}:$(bat ${password})@${url}";
                TimeoutStopSec = "180";
                KillMode = "process";
                KillSignal = "SIGINT";
              };
              Install.WantedBy = [ "multi-user.target" ];
            };
          })
          synclist
        ));
    timers =
      (builtins.listToAttrs
        (map
          (opts: {
            name = "${opts.name}";
            value = {
              Unit.Description = "Automatic sync files with Nextcloud when booted up after 1 minute then rerun every 60 minutes";
              Timer.OnBootSec = "1min";
              Timer.OnUnitActiveSec = "60min";
              Install.WantedBy = [ "multi-user.target" "timers.target" ];
            };
          })
          synclist
        ));
    startServices = true;
  };
}
