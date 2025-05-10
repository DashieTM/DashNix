{lib, ...}: {
  options.mods = {
    nextcloud = {
      enable = lib.mkOption {
        default = true;
        example = false;
        type = lib.types.bool;
        description = "Enable nextcloud";
      };
      username = lib.mkOption {
        default = "";
        example = "globi";
        type = lib.types.str;
        description = "Your username";
      };
      url = lib.mkOption {
        default = "";
        example = "cloud.globi.org";
        type = lib.types.str;
        description = "Your url";
      };
      synclist = lib.mkOption {
        default = [];
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
}
