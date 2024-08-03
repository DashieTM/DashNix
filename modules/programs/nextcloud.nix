{ lib, config, pkgs, options, ... }: {
  options.mods = {
    nextcloud = {
      enable = lib.mkOption {
        default = true;
        example = false;
        type = lib.types.bool;
        description = "Enable nextcloud";
      };
      username = lib.mkOption {
        default = "DashieTM";
        example = "globi";
        type = lib.types.str;
        description = "Your username";
      };
      url = lib.mkOption {
        default = "cloud.dashie.org";
        example = "cloud.globi.org";
        type = lib.types.str;
        description = "Your url";
      };
      synclist = lib.mkOption {
        default = [ ];
        example = [
          {
            name = "sync globi folder";
            remote = "globi";
            local = "/home/globi";
          }
        ];
        description = ''
          A list of folders to synchronize.
          This has to be an attribute list with the name, remote and local field (all strings).
        '';
      };
    };
  };

 # config =
 #   let
 #     username = config.mods.nextcloud.username;
 #     password = config.sops.secrets.nextcloud;
 #     url = config.mods.nextcloud.url;
 #     synclist = config.mods.nextcloud.synclist;
 #     name = "test";
 #     local = "test";
 #     remote = "test";
 #   in
 #   lib.mkIf config.mods.nextcloud.enable
 #     (lib.optionalAttrs (options?systemd.user.startServices) #{
 #       builtins.listToAttrs
 #       (map
 #         ({ name, remote, local }: {
 #           systemd.user = {
 #             services."${name}" = {
 #               Unit = {
 #                 Description = "Auto sync Nextcloud";
 #                 After = "network-online.target";
 #               };
 #               Service = {
 #                 Type = "simple";
 #                 ExecStart = "${pkgs.nextcloud-client}/bin/nextcloudcmd -h --path ${remote} ${local} https://${username}:${password}@${url}";
 #                 TimeoutStopSec = "180";
 #                 KillMode = "process";
 #                 KillSignal = "SIGINT";
 #               };
 #               Install.WantedBy = [ "multi-user.target" ];
 #             };
 #             timers.${name} = {
 #               Unit.Description = "Automatic sync files with Nextcloud when booted up after 1 minute then rerun every 60 minutes";
 #               Timer.OnBootSec = "1min";
 #               Timer.OnUnitActiveSec = "60min";
 #               Install.WantedBy = [ "multi-user.target" "timers.target" ];
 #             };
 #             startServices = true;
 #           };
 #           # });
 #         }))
 #       synclist
 #     );
}
