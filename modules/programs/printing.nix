{ lib, config, options, pkgs, ... }: {
  options.mods.printing = {
    enable = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Enables the piper program and its daemon";
    };
  };
  config = lib.mkIf config.mods.printing.enable
    (lib.optionalAttrs (options?services.printing)
      {
        # Enable CUPS to print documents.
        services.printing.enable = true;
        services.printing.browsing = true;
        services.printing.drivers = [ pkgs.hplip ];
        services.printing.startWhenNeeded = true; # optional
        services.avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };
      });
}
