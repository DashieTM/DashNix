# with friendly help by stylix: https://github.com/danth/stylix/blob/master/docs/default.nix
{ pkgs, build_systems, ... }:

let
  makeOptionsDoc =
    configuration:
    pkgs.nixosOptionsDoc {
      inherit (configuration) options;

      # Filter out any options not beginning with `stylix`
      transformOptions =
        option:
        option
        // {
          visible =
            option.visible
            && (builtins.elemAt option.loc 0 == "conf" || builtins.elemAt option.loc 0 == "mods");
        };
    };
  example = makeOptionsDoc (build_systems [ "example" ] ../example/.)."example";
in
pkgs.stdenvNoCC.mkDerivation {
  name = "dashNix-book";
  src = ./.;

  patchPhase = ''
    sed '/*Declared by:*/,/^$/d' <${example.optionsCommonMark} >> src/dashNix.md
  '';
  buildPhase = ''
    ${pkgs.mdbook}/bin/mdbook build --dest-dir $out
  '';
}
