self: { lib
      , config
      , pkgs
      , options
      , ...
      }:
let
  cfg = config.programs.dashvim;
  system = pkgs.stdenv.hostPlatform.system;
  # dashvim = (import ../lib { inherit system pkgs; inputs = self.inputs; config' = cfg; });
in
{
  imports = [ ../modules ];
  meta.maintainers = with lib.maintainers; [ DashieTM ];
  options.programs.dashnix = with lib; {
    enable = mkEnableOption "dashvim";

    package = mkOption {
      type = with types; nullOr package;
      default = dashvim.build_dashvim;
      defaultText = literalExpression ''
        ReSet.packages.''${pkgs.stdenv.hostPlatform.system}.default
      '';
      description = mdDoc ''
        Package to run
      '';
    };
  };
  config = lib.mkIf cfg.enable
    (lib.optionalAttrs (options?home.packages)
      {
        home.packages = lib.optional (cfg.package != null) cfg.package;
      } //
    lib.optionalAttrs (options?environment.systemPackages) {
      environment.systemPackages = lib.optional (cfg.package != null) cfg.package;
    });
}
